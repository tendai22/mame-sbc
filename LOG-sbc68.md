# sbc6800 と sbc6809 のビルド

この項は @ryu10 が記述しました。

## 環境

* Ubuntu 24.04LTS 
* Parallels 14
* Intel Mac mini

## リポジトリのフォーク

@tendai22 様の v0.992 (2024/12/5 版) からフォークしました。

https://github.com/tendai22/mame-sbc

## sbc6800 ブランチ

makefile の `TARGET=sbc6800` 行を有効にして make します。

### ソースコード変更点

* src/emuz80 をひな形に
* src/sbc6800 以下にマシンを記述
    * 起動時に RESET ピン操作が必要
* src/devices/cpu/m6800 以下を本家 mame から復元
* scripts 以下の lua ビルドスクリプトを編集
* その他

詳細は下記の差分リンクをご覧ください。

https://github.com/tendai22/mame-sbc/compare/main...ryu10:mame-sbc:sbc6800

## sbc6809 ブランチ

makefile の `TARGET=sbc6809` 行を有効にして make します。

### ソースコード変更点

* sbc6800 と同じ要領で記述
    * RESET ピン操作しなくても起動する

## sbc68 ブランチ

* sbc6800 + sbc6809
* このファイル LOG-sbc68.md を追加
