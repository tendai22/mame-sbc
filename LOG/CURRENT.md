# デバッガ機能の復活

mame ソースコードを探索して、debugger 機能を有効にする方法を探る。

## デバッガ呼び出し

CPUループからデバッガを呼び出す。

```
	debugger_instruction_hook(m_pc);
```

この定義は diexec.h にあり、ヘッダ定義関数。

```
void device_execute_interface::debugger_instruction_hook(offs_t curpc)
{
	if (device().machine().debug_flags & DEBUG_FLAG_CALL_HOOK)
		device().debug()->instruction_hook(curpc);
}
```

device() は型 device_t で、class device_t はヘッダにある。

```
	device_t &device() { return m_device; }
```

なので、メンバ参照 m_device を返す。

device().debug() は、device_debug 型を返す。

```
device_debug *debug() const { return m_debug.get(); }
```

m_debug は device_t クラスのメンバで、

```
std::unique_ptr<device_debug> m_debug;
```

である。instruction_hook() も device_debug クラスのメンバ関数。定義は `debugcpu.cpp` にある。

* pc をトラッキングしている。
* traceしているなら、 `m_trace->update(curpc);` を呼び出す。
* シングルステップ処理。
  + `curpc == m_stepaddr` ならば、set_execution_stopped() を呼び出し、ブレークポイントをリセットする。
  + m_delay_steps が非ゼロならばデクリメントして、ゼロとなると set_execution_stopped() を呼び出す。
* debug_view() の更新・debugger().refresh_display() する。

set_execution_stopped() 関数。m_execution_state に STOPPED を代入するだけ。

```
void debugger_cpu::set_execution_stopped() { m_execution_state = exec_state::STOPPED; }
```

命令実行中の hook では、m_executon_state の値を書き換えるだけ。実際のデバッグコマンド入力と実行は別のコンテキストにある。

### デバッガコマンド入力と実行

では、m_execution_state の値を見て動きを変えるところを探す。

```
	exec_state execution_state() const { return m_execution_state; }
	bool is_stopped() const { return m_execution_state == exec_state::STOPPED; }
	bool is_running() const { return m_execution_state == exec_state::RUNNING; }
```

あたり。is_stopped()を探す。

* void debugger_console::process_source_file() 中で、ソースファイルの行を読み込み execute_command している。
* void debugger_cpu::wait_for_debugger(device_t &device) 中で、
  + メモリが更新されていれば debugger_view に反映させる。
  + process_source_file(): ソースファイルを処理する。
  + scheduled_event_pending() ならば set_execution_running() する。

デバッグコマンド処理コンテキストは debugger_cpu::wait_for_debugger(device_t &device) のようだ。

デバッグコマンド実行は void debugger_console::process_source_file() がキモらしい。

#### wait_for_debugger を呼び出すのはだれか？

instruction_hook 中に呼び出し口がある。

```
	// if we are supposed to halt, do it now
	if (debugcpu.is_stopped())
		debugcpu.wait_for_debugger(m_device);
```

命令実行中/is_stopped() の間は、wait_for_debugger をポーリングしていることが分かる。

### debug_module::wait_for_debugger もある

debug_module クラスがあり、これも wait_for_debugger メンバ関数を持っている。

```
	virtual void wait_for_debugger(device_t &device, bool firststop) = 0;
```

debug_module クラスと debugger_cpu との関係は如何に？

例えば debug_gdbstub クラスは debug_module を基底クラスとして持つ。

debugger_cpu クラスはベースクラスを持たない。

debugger_manager クラスが debugger_cpu クラスをメンバに持つ。

debugger_cpu::wait_for_debugger メンバ関数中で2引数 wait_for_debugger を呼び出している。

```
if (m_machine.debug_flags & DEBUG_FLAG_OSD_ENABLED)
	m_machine.osd().wait_for_debugger(device, firststop);
```

たぶんこの中でデバッグコマンド実行もしている。

m_machine は running_machine クラスで、各デバイスのprivateメンバである。

m_machien.osd() は machine_manager クラスの osd() を返す。結局、machine_manager クラスの m_osd メンバを返す。m_osd は class osd_interface である。

ということで、osd_interface::wait_for_debugger である。2 引数の overridable 関数だ。

```
virtual void wait_for_debugger(device_t &device, bool firststop) = 0;
```

osd_interface::wait_for_debugger メンバ関数の定義は存在しないので、osd_interface の派生クラスでの定義を調べる。

#### osd_interface の用法

osd_module が select_module するときに、osd_module::init(osd, options) で osd_interface が渡される。

osd_module::init は存在しない。よって、osd_module の派生クラスの init メンバ関数を見る。

osd_common_t クラスが osd_interface の派生クラスであり、こいつも wait_for_debugger を持つので、これを見る。

```
void osd_common_t::wait_for_debugger(device_t &device, bool firststop)
{
	//
	// When implementing an OSD-driver debugger, this method should be
	// overridden to wait for input, process it, and return. It will be
	// called repeatedly until a command is issued that resumes
	// execution.
	//
	m_debugger->wait_for_debugger(device, firststop);
}
```

osd_commont_t クラスの m_debugger プライベートメンバが debug_module へのポインタなので、ここで debug_module::wait_for_debugger() につながる。

debug_gdbstub クラスの基底クラスに osd_module を持つので、ここで debugモジュールとのつながりが得られる。

つまり、osd_common_t パートの初期化の際に m_debugger に適切な debug_module を差し込むと debug_module::wait_for_debugger が呼び出される。

#### m_debugger に debug_module を差し込む

running_machne::m_debugger は debuger_manager クラスで、debug_module クラスではないが、

running_machne::start() 中で debug_flags & DEBUG_FLAG_ENABLED が立っていれば、

```
m_debugger = std::make_unique<debugger_manager>(*this);
```

で初期化される。直接関係ない。

osd_common_t::init_subsystems() 中で、

```
m_debugger = &select_module_options<debug_module>(OSD_DEBUG_PROVIDER);
```

で初期化される。

init_subsystems() を呼び出すのは、windows_osd_interface::init(), sdl_osd_interface::init() の中である。

> tty_osd_interface クラスを sdl_osd_interface に倣って派生させるか。

たぶん、

* tty_osd_interface を作成し、init() で初期化する。

#### osd_common_t::init を呼び出すのは？

そろそろ running_machine あたりにたどり着いてもよさそうだが。

m_machine.osd() は、m_manager.osd() を呼ぶ。

running_machine に差し込まれた m_manager (machine_manager クラス)のosd()を呼び出す。

m_manager.osd() は、osd_interface & m_osd を返す。なので、machine_manager に osd を差し込むことになる。

machine_manager クラスも running_machine *m_machine メンバを持っているので、machine_manager クラスと running_machine クラスは相互に指している。

running_machine::start() の中で、m_manager.osd().init(*this) を呼び出すので、ここでつながる。

```
	// init the OSD layer
	m_manager.osd().init(*this);
```

#### zexallでどうするか？

zexall_machine_manager を machine_manager から派生させて zexall_machine_manager::instance() 内部で、m_manager を初期化、m_manager を返している。

tty_osd_interface クラスを作成し、tty_osd_interface::init() 関数をダミーで作る。

running_machine::start() が呼び出されるか、start() 中で tty_osd_interface::init() が呼び出されるかが最初のチェックポイントとなるだろう。ここを目指して試作する。

以下の process_sourcefile はごみとなる、UNUSED.md送り。

## tty_osd_interface を作る。

* tty_osd_interface を作る。
  + src/osd/tty ディレクトリを作って、その下に、ttymain.cpp, window.cpp を作ってゆくことなる。
  + emuz80 で、tty_osd_interface::init() が呼び出されているかを確認する。

* debug_tty も合わせて作る。
  + src/osd/modules/debugger/none.cpp を複製して tty.cpp を作り、名前文字列 "tty" で始める。
  + wait_for_debugger は少し工夫が必要だろう。debugger_cpu::wait_for_debugger から呼び出されていることを確認して、この中でデバッグコマンドプロセッサを動かす。

* osd_common_t::init_subsystems() 中で、

```
m_debugger = &select_module_options<debug_module>(OSD_DEBUG_PROVIDER);
```

で差し込まれるので、select_module_options で tty_debug_module(いや debug_tty) が選択されるように表を作る。

## 2025/1/21: tty_osd_interface 作ってみた。

* src/osd/tty/video.cpp も必要だった。(video_config構造体がそこここで参照されていた)
* emuz80 で tty_osd_interface::init() 呼び出された。

相変わらず、重い `video.cpp`/`window.cpp` を抱えたままだが、これを抱えることでビルドがつつがなく進む。

よし、先に進もう。

## debug_tty 作ってみた。

* tty.cpp 最後で DEBUG_TTY で MODULE_DEFINITION した。
* osdobj_common.cpp 途中で REGISTER_MODULE した。

この状態で、emuz80 起動しても init_debugger() は呼び出されない。

しらべてみると、src/emu/machine.cpp で、debug_flags & DEBUG_FLAG_ENABLED ビットが立っている必要がある。

running_machine のコンストラクタの最後で、

```
	// fetch core options
	if (options().debug() || 1)	// make it true temporally
		debug_flags = (DEBUG_FLAG_ENABLED | DEBUG_FLAG_CALL_HOOK) | (DEBUG_FLAG_OSD_ENABLED);

```

とあるので、ここを強制的にtrue にしてみたら、init_debugger が呼び出された。

```
kuma@LAURELEY:~/mame-sbc$ !.
./emuz80
debug_tty constructor invoked
emuz80_state: constructor
uart_device: constructor, baudrate = 9600
tty_osd_interface::init: invoked
debug_tty::init_debugger:
uart_device::device_start, tick = 1000
reset_input_device
warning_txt = -1
uart_device::device_reset
machine_reset

␦txd: overrun
Z80 BASIC Ver 4.7b
Copyright (C) 1978 by Microsoft
24190 Bytes free
Ok
```

`debug_tty::init_debugger:` が見える。よし、デバッガ(`debug_tty`)が呼び出されている。

### options 引数オプションの解釈

結局のところ、emulator_info::start_frontend() の中で、args を順に回して解釈、設定する必要がある。

* 現在のところ、args を解釈するコードは main.cpp に入っていない。
* オプションの設定は、emulator_info::start_frontend() 内部で、以下のようなコードを呼び出して行う。

```
	options.set_value(OPTION_DEBUG, true, OPTION_PRIORITY_MAXIMUM);
	options.set_value(OPTION_THROTTLE, false, OPTION_PRIORITY_MAXIMUM);
```

* 各エミュレータごとに main.cpp を別に取っているので、共通の argparse コードで実装するべき。
* 現在はOPTION_DEBUG 行のコメントアウトを外して、上記 true を有効にしている。

これで、debugger が有効になっている。

### OSD_DEBUG_PROVIDER

```
m_debugger = &select_module_options<debug_module>(OSD_DEBUG_PROVIDER);
```

で差し込まれるので、select_module_options で debug_tty のインスタンスが選択されるように表を作る。

select_module_options の定義は、

```
	template<class C>
	C &select_module_options(const std::string &opt_name)
	{
		std::string opt_val = options().exists(opt_name) ? options().value(opt_name) : "";
		if (opt_val == "auto")
		{
			opt_val = "";
		}
		else if (!m_mod_man.type_has_name(opt_name.c_str(), opt_val.c_str()))
		{
			osd_printf_warning("Value %s not supported for option %s - falling back to auto\n", opt_val, opt_name);
			opt_val = "";
		}
		return m_mod_man.select_module<C>(*this, options(), opt_name.c_str(), opt_val.c_str());
	}
```

なので、m_mod_man を見る。osd_module_manager クラスなので、

* osd_module_manager::get_module_generic で検索する。
* この中で、osd_module_manager::get_module_index で検索している。
* m_modules の表をリニアサーチしている。

```
	for (int i = 0; m_modules.size() > i; i++)
	{
		if ((m_modules[i]->type() == type) && (!name[0] || (m_modules[i]->name() == name)))
			return i;
	}
	return -1;
```

### m_debugger に強引に差し込むには?

```
osd_module &osd_module_manager::select_module(osd_interface &osd, const osd_options &options, const char *type, const char *name)

```

なので、osd_module または派生クラスを強引に差し込めばよい。

osd_common_t::init_subsystems() 中で、

```
m_debugger = &select_module_options<debug_module>(OSD_DEBUG_PROVIDER);
```

で差し込まれる。m_debugger に debug_tty のインスタンスを代入すればよいのだろう。

### osd_printf_verbose

話は変わるが、この機会に osd_printf_verbose 他を osd_printf_XXXX を調べた。

osd_printf_verbose は、osd_vprintf_verbose を呼び出しており、osd_vprintf_verbose が、output_callback を呼び出している。

```
void osd_common_t::output_callback(osd_output_channel channel, const util::format_argument_pack<char> &args)
```

につながる。実際にこのcallbackは呼び出されている。

```
//-------------------------------------------------
//  output_callback  - callback for osd_printf_...
//-------------------------------------------------
void osd_common_t::output_callback(osd_output_channel channel, const util::format_argument_pack<char> &args)
{
	switch (channel)
	{
	case OSD_OUTPUT_CHANNEL_ERROR:
	case OSD_OUTPUT_CHANNEL_WARNING:
		util::stream_format(std::cerr, args);
		break;
	case OSD_OUTPUT_CHANNEL_INFO:
	case OSD_OUTPUT_CHANNEL_LOG:
		util::stream_format(std::cout, args);
		break;
	case OSD_OUTPUT_CHANNEL_VERBOSE:
		if (verbose()) util::stream_format(std::cout, args);
		break;
	case OSD_OUTPUT_CHANNEL_DEBUG:
#ifdef MAME_DEBUG
		util::stream_format(std::cout, args);
#endif
		break;
	default:
		break;
	}
}
```

osd_printf_verbose の引数が出力されるには、

```
	options.set_value(OPTION_VERBOSE, true, OPTION_PRIORITY_MAXIMUM);
```

で、OPTION_VERBOSE を設定すると osd_printf_verbose 出力が出るようになる。

osd_printf_debug の引数が出力されるようにするには、マクロ MAME_DEBUG をtrueにするとよい。

### m_debugger への代入、されていた。

`m_debugger =` への代入は2か所あるが、いずれも通過している。そのあと、`debug_tty::init_debugger` が呼び出されている。ということで、現状で debug_tty の初期化とデバッガの呼び出し準備が整っているのだろう。次は 

この状態で、debug_tty::debuger_update は常時呼び出されている。

wait_for_debugger の呼び出し条件を再度確認する。

### CPU実行側のシングルステップ処理

```
void device_debug::instruction_hook(offs_t curpc)
{
	...
	if (!debugcpu.is_stopped() && (m_flags & DEBUG_FLAG_STEPPING_ANY) != 0)
	{
		bool do_step = true;
		if ((m_flags & (DEBUG_FLAG_CALL_IN_PROGRESS | DEBUG_FLAG_TEST_IN_PROGRESS)) != 0)
		{
			if (curpc == m_stepaddr)
			{
				if ((~m_flags & (DEBUG_FLAG_TEST_IN_PROGRESS | DEBUG_FLAG_STEPPING_BRANCH_FALSE)) == 0)
				{
					debugcpu.set_execution_stopped();
					do_step = false;
				}
	...

```
なので、debugcpu.m_flags に DEBUG_FLAG_TEST_IN_PROGRESS を立てればよさそうだ。

### breakpoint を設定する。

ここまで来たら、コードを触るよりも breakpoint をセットして様子を見たい。

debugger_command::execute_bpset の中で、

```
	int const bpnum = debug->breakpoint_set(address, condition.is_empty() ? nullptr : condition.original_string(), action);
```

で設定している様子。debug は、device_debug クラスのようだ。

debugger_commands のコンストラクタ内で、execute_bpset 呼び出しのコマンドが登録されている。ここから、"bpset" または "bp" で設定できるようだ。

```
	m_console.register_command("bpset",     CMDFLAG_NONE, 1, 3, std::bind(&debugger_commands::execute_bpset, this, _1));
	m_console.register_command("bp",        CMDFLAG_NONE, 1, 3, std::bind(&debugger_commands::execute_bpset, this, _1));
```

コマンド登録先は、m_commandlist らしい。

コマンド実行関数は、

```
CMDERR debugger_console::internal_execute_command(bool execute, std::vector<std::string_view> &params)
```

である。internal_execute_command を呼び出すところは、

```
CMDERR debugger_console::internal_parse_command(std::string_view command, bool execute)
```

である。command 文字列を解釈してコマンドを実行している(この中でinternal_execute_command を呼び出している)。

internal_parse_command の呼び出しは、

```
CMDERR debugger_console::execute_command(std::string_view command, bool echo)
```

であり、これを呼び出すところは、

```
CMDERR debugger_console::execute_command(std::string_view command, bool echo)
```

である。execute_command を呼び出す個所は多い。debugcpu.cpp 内部でも多数ある。

デバッガループは、

```
void debugger_console::process_source_file()
```

である。

* instruction_hook() の中で、 `debugcpu.is_stopped()` であれば、 `process_source_file` が呼び出される。
* process_source_file の中で、 `m_source_file` が非ゼロであれば、`std::getline` でコマンド行を読み込んで実行、のループを繰り返す。

CPUを止めてしまうと実行最初からデバッガループに入る。

m_source_file は、

```
std::unique_ptr<std::istream> m_source_file;        // script source file
```

である。`debugger_console::source_script(const char *file)` で渡したファイル名で初期化される。

ssource_script は、

1. オプション debug_script で指定したファイル名

'''
const char* name = m_machine.options().debug_script();
	if (name[0] != 0)
		m_console.source_script(name);
'''

2. debugger_commands::execute_source による。"source" コマンド

void debugger_commands::execute_source(const std::vector<std::string_view> &params)

起動時に `m_console.source_script("/dev/tty");` を入れて様子を見よう。

あとは、debugcpu::is_stopped() にすること。TCPソケットに source_script を繋ぎこんで様子を見るか。

* telnetd をある pty に対して起動しておく。
* emuz80 起動時にそのptyデバイスに対してsource_scriptを実行する。

かな。telnetd で pty を待てるなら、telnet コマンドで別コンソールからデバッガを制御できるようになる。たぶん、これが最初の目標になる。

### デバッガの動作確認

最初は /dev/tty で様子を見る、やな。

初期化時にデバッグコマンドを叩いておく、

* debugger_cpu::set_execution_stopped() を呼び出す。
* m_console.source_script("/dev/tty");
* "bpset 0" しておく。
* "go 0" する。

これで実行開始するかどうかを見る。

### 久々に(2/10)

1/23 以来3週間近く空いた。

* m_console は debugger_manager のメンバ。
* debugger_manager クラスは、running_machine.m_debugger メンバで初期化される。
* 初期化は、`(debug_flags & DEBUG_FLAG_ENABLED) != 0` の時に行われる。
* `fprintf(stderr, "m_debugger: assigned in running_machine::start\n");`
が表示されているので、この if 節には入っている。m_debugger は初期化されている。
* `void debug_tty::wait_for_debugger(device_t &device, bool firststop)`
が呼び出されている。

### m_console.source_script("/dev/tty");

を呼び出してみた。確かに std::getline(*m_script_file, buf) に来ているが、ここでキーを叩いても無反応である。

### wait_for_debugger 内部で行入力ループを回した。

これはうまくいった。リターンキーを叩くと実行再開した。やはり go() で実行再開するらしい。

```
void debug_tty::wait_for_debugger(device_t &device, bool firststop)
{
	fprintf(stderr, "debug_tty: wait_for_debugger\n");
	if (firststop) {
		fprintf(stderr, "wait_for_debugger: first stop\n");
	}
	fprintf(stderr, ">> ");
	fflush(stderr);
	int ch;
	while ((ch = getch()) > 0) {
		if (ch == '\n' || ch == '\r') {
			fprintf(stderr, "restart\n");
			break;
		}
		putch(ch);
	}
	m_machine->debugger().console().get_visible_cpu()->debug()->go();
}
```

### コマンド実行させてみるか。

execute_command で検索掛けると、

```
void MainWindow::toggleBreakpointAtCursor(bool changedTo)
{
	debug_view_disasm *const dasmView = m_dasmFrame->view()->view<debug_view_disasm>();
	if (dasmView->cursor_visible() && (m_machine.debugger().console().get_visible_cpu() == dasmView->source()->device()))
	{
		offs_t const address = dasmView->selected_address();
		device_debug *const cpuinfo = dasmView->source()->device()->debug();

		// Find an existing breakpoint at this address
		const debug_breakpoint *bp = cpuinfo->breakpoint_find(address);

		// If none exists, add a new one
		std::string command;
		if (!bp)
			command = string_format("bpset 0x%X", address);
		else
			command = string_format("bpclear 0x%X", bp->index());
		m_machine.debugger().console().execute_command(command, true);
		m_machine.debug_view().update_all();
		m_machine.debugger().refresh_display();
	}
}
```

こんなコードが見つかったから,

```
m_machine.debugger().console().execute_command(command, true);
```

これでいいんだろう。

### uint8_t buf[MAXBUF] を食わせてもコマンドを実行する。

char 型バッファにコマンド文字列を読み込ませて execute_command の引数に渡してもコマンドが呼び出された。

```
#define MAXBUF 80
	int ch, i;
	uint8_t buf[MAXBUF];
	i = 0;
	while (i < MAXBUF && (ch = getch()) > 0) {
		if (ch == '\n' || ch == '\r') {
			fprintf(stderr, " EOL\n");
			buf[i] = '\0';
			break;
		}
		buf[i++] = ch;
		putch(ch);
	}
	// execute_commands
	m_machine->debugger().console().execute_command((const char *)buf, true);
```

execute_help の先頭に fprintf かませて、help と入力すると fprintfメッセージが出た。
しかし、ヘルプメッセージが表示されていない。

```
void debugger_commands::execute_help(const std::vector<std::string_view> &params)
{
	fprintf(stderr, "execute_help: doing\n");
	if (params.size() == 0)
		m_console.printf_wrap(80, "%s\n", debug_get_help(std::string_view()));
	else
		m_console.printf_wrap(80, "%s\n", debug_get_help(params[0]));
}
```

m_console.printf_wrap が表示できていないのか。

### class text_buffer

デバッグコマンドの出力は、いったん text_buffer クラスのメンバに貯えられる。それを flush していないので、何も表示されないのだった。

text_buffer にたまったメッセージをフラッシュする関数を作った。

```
void debug_tty::flush_text_buffer(void)
{
	text_buffer &textbuf = m_machine->debugger().console().get_console_textbuf();
	for (std::string_view line_info : text_buffer_lines(textbuf))
	{
		fwrite(line_info.data(), sizeof(char), line_info.length(), stderr);
		fputc('\n', stderr);
	}
}
```

### デバッガのメインループ

コマンド入力を受けて、実行、goコマンドを得るとデバッガを抜けて実行再開、というメインループを構築した。

```
	flush_text_buffer();
	while (true) {
		fprintf(stderr, ">> ");
		fflush(stderr);
		i = getline(buf, MAXBUF);
		if (strcmp((const char *)buf, "go") == 0) {
			m_machine->debugger().console().get_visible_cpu()->debug()->go();
			break;
		}
		// execute_commands
		if (i > 0) {
			m_machine->debugger().console().execute_command((const char *)buf, true);
			flush_text_buffer();
		}
	}
```

getline は自作で、DEL or Ctrl-H で1文字消去、リターンで抜けてくる。debug_tty::getch/putch を使用している。

これで、MAME debugger が動くようになった。

```
m_debugger: assigned in running_machine::start
debugger_commands constructor
debug_tty::init_debugger:
uart_device::device_start, tick = 1000
reset_input_device
uart_device::device_reset
machine_reset
debug_tty: wait_for_debugger
wait_for_debugger: first stop
Currently targeting emuz80 (emuz80 (Z80 with PIC18F47Q53))
>> bpset 0 EOL
n = 7
execute_command: bpset 0
echo: bpset 0
pos = 0
[b][p][s][e][t][ ][0]command: bpset 0
command: bpset
Currently targeting emuz80 (emuz80 (Z80 with PIC18F47Q53))
>bpset 0
Breakpoint 1 set
>>
```

あらら、前のメッセージがまた出てきている。text_buffer をクリアしないといかんですね。



