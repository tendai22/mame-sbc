## 2025-1-16: デバッガ探索時の枝刈り刈り

#### process_source_file を探る

* std::getline(*m_source_file, buf) でソースファイルを読み込んで
* execute_command(buf, true); を繰り返し呼ぶ。

m_source_file はstd::istreamのポインタである。

```
std::unique_ptr<std::istream> m_source_file;        // script source file
```

m_source_file は debugger_console::source_script(const char *file) で初期化される。

* debugger_commands::execute_source(...) 中で呼び出される。
* debugger_console::source_script(const char *file)は m_source_file を初期化するだけ。

debugger_console::execute_command(std::string_view command, bool echo) らしい。

文字列処理、セミコロンまで解釈後、internal_execute_command(execute, params); または代入式評価(expr.execute())する。

internal_execute_command(bool execute, std::vector<std::string_view> &params) では、コマンドパーズ後、最終的に found->handler(params) を呼び出している。

コマンドサーチは m_commandlist.lower_bound(command.c_str()) で行われる。

```
auto const found = m_commandlist.lower_bound(command.c_str());
```

std::lower_bound() はソートされた列から「キーより大きい」値のエントリを返す。やはり m_commandlist のエントリを定義しているところを探す。

### m_commandlist エントリ登録

m_commandlist はクラス debugger_console のメンバである。型は `std::set<debug_command, debug_command::compare> m_commandlist;` STLの set である。

定数による初期化はなさそう。debugger_console::register_command() で登録するらしい。この中で、m_commandlist.emplace() を呼び出している。これも STL 標準(`set::emplace()`)、要素を生成して差し込む。

```
auto const ins = m_commandlist.emplace(command, flags, minparams, maxparams, std::move(handler));
```

クラス debugger_commands のコンストラクタで大量に差し込まれている。

```
	// add all the commands
	m_console.register_command("help",      CMDFLAG_NONE, 0, 1, std::bind(&debugger_commands::execute_help, this, _1));
	m_console.register_command("print",     CMDFLAG_NONE, 1, MAX_COMMAND_PARAMS, std::bind(&debugger_commands::execute_print, this, _1));
	m_console.register_command("printf",    CMDFLAG_NONE, 1, MAX_COMMAND_PARAMS, std::bind(&debugger_commands::execute_printf, this, _1));
	...
	(以下略)
```

ここを見ればデバッグスクリプトのコマンドが分かる。結構多い。

### クラス debugger_console 

どうやらこのクラスがコマンド入力と実行を担当しているらしい。

