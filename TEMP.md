## mame のオプション調査

* emuopt.h に OPTION_XXXX マクロとアクセス関数(例: options.log())が定義されている。
* カテゴリは、
  + core configuration options
  + core search path options
  + core directory options
  + core state/playback options
  + core performance options
  + core render options
  + core rotation options
  + core artwork options
  + core screen options
  + core vector options
  + core sound options
  + core input options
  + core debugging options
  + core misc options
  + core comm options
  + misc(confirm_quit, ui_mouse, autoboot_command, autoboot_delay, autoboot_script, console, plugins, plugin, no_plugin, language)
  + web server specific options
  + slot and devices - the values for these are stored outside of core options structure

### core debugging options

 |name|type|description|
 |--|--|--|
 |log()|bool|
 |debug()|bool|
 |verbose()|bool|
 |oslog()|bool|
 |debug_script()|const char *|
 |update_in_pause()|bool|
 |debuglog()|bool|

### カテゴリ無し

 |name|type|description|
 |--|--|--|
 |confirm_quit()|bool|マシン実行時に、ログファイルを作成する
 |ui_mouse()|bool|mame_ui_manager で専用のポインタを表示する
 |autoboot_command()|const char *|コマンド文字列。autoboot_delay時間経過後、autoboot_callback() 内部で「キー入力があったように」をこの文字列を実行する。
 |autoboot_delay()|int|リセット後 autoboot_command, autoboot_scriptを実行するまでの待ち時間(attotime)。
 |autoboot_script()|const char *|autoboot_script()が指定されていた場合、luaスクリプトとして実行する。
 |console()|bool|console plugin をオープンする。
 |plugins()|bool|options().plugins()で参照する。plugin_options.plugins()はリストを返す。それとは別らしい。本オプションがtrueの場合、plugins_path()をディレクトリ名とみなして、そのディレクトリをスキャンして探すようだ。
 |plugin()|const char *|インクルードするplugin名のカンマ区切り
 |no_plugin()|const char *|エクスクルー度するplugin名のカンマ区切り
 |language()|const char *|

### web server specific options

 |name|type|description|
 |--|--|--|
 |httl()|bool|
 |http_port()|short|
 |http_root()|const char *|

### 他

* slot and devices がある。slot_option クラス、image_option クラスがある。
* protected 関数 command_argument_processed()
　

