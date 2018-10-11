# 基礎プログラミングおよび演習レポート ＃02

\
学籍番号: 1810156
\
氏名: 奥山 亮太郎
\
ペア学籍番号・氏名(または「個人作業」): 「個人作業」
\
提出日付: 2018/10/12

## レポートに関する注意点等(お願い)

前回レポートに引き続きマークダウン記法を多用しています。

また前回レポートでは用意できませんでしたが、見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ]()に用意しました。
\
もし見づらいと感じられた場合はこちらからお願いします。

## [課題の再掲]

### 演習 2

- a: 2つの異なる実数`a`、`b`を受け取り、より大きいほうを返す。 (activity report にて提出したので飛ばす)
- b: 3つの異なる実数`a`、`b`、`c`を受け取り、最大のものを返す。
- c: 実数を 1 つ受け取り、それが正なら`"positive"`、負なら`"negative"`、零なら`"zero"`という文字列を返す。

### 演習 3

演習 3はレポート範囲外であるが、よく取り組んだので一応レポートに含めることにした。(一方演習 1の内容は前回レポートと被るという理由もあり載せない。)

- テキストにある数値積分の式を実装、実行したのちに特徴を観察し、以下の方法で改善を試みる。
    - a: 左端の`x`だけでも右端の`x`だけでも弱点があるので、両方で計算して平均を取る。
    - b: 左端や右端だからよくないので、区間の中央の`x`を使う。
    - c: 上記`a`と`b`をうまく組み合わせてみる。

### 演習 4

繰り返しを使った以下のようなプログラムを作成する。

- a: 非負整数`n`を受け取り、`2^n`を計算する。
- b: 非負整数`n`を受け取り、`n! = n × (n − 1) × ... × 2 × 1`を計算する。
- c: 非負整数`n`と`r(≤ n)`を受け取り、`nCr`を計算する。
- d: `x`と計算する項の数`n`を与えて、`sin`、`cos`関数のテイラー展開を計算する。

### 演習 5

2つの正の整数`x`、`y`に対してその最大公約数を求めるアルゴリズムの疑似コードを書き、Ruby プログラムを作成する。
\
また、この方法の原理を説明する。

### 演習 6

「正の整数`N`を受け取り、`N`が素数なら`true`、そうでなければ`false`を返すRubyプログラム」を書く。まず疑似コードを書き、次にRubyに直す。

### 演習 7

「正の整数`N`を受け取り、`N`以下の素数をすべて打ち出すRubyプログラム」を書く。待ち時間`10`秒以内でいくつの`N`まで処理できるか調べて報告する。

## [実施したこととその結果]

## [考察]

## [アンケート]
- Q1. 枝分かれや繰り返しの動き方が納得できましたか?
    - a

- Q2. 枝分かれと繰り返しのどっちが難しいですか? それはなぜ?
    - b

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。
    - c