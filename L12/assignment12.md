# 基礎プログラミングおよび演習レポート #12

学籍番号: 1810156
\
氏名: ** ***
\
ペア学籍番号・氏名(または「個人作業」): 個人作業
\
提出日付: 2019/1/15

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L12/assignment12.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- `~~ 省略 ~~`として一部実行結果を省略している箇所があります。
- 可読性を考慮し、一部関数名を変更しています。変更はなるべく記載しておりますが、アンダーバーを付けただけのものなどはっきりとわかるものについては省略している場合もあります。
- 基本的にスネークケースを採用しています。なお、`_to_`(キャストを表す関数などに用いられる)は`2`で代用しています。
- 字数の都合上、`main`関数を含めた「プログラム全体」は表示していない場合があります。全体についてはgithubから確認できます。

## [課題の再掲]

### 演習 1 配列の各種表示・操作

次の関数を実装する。

- a. 整数配列を「後ろから順に」打ち出す関数`void piarrayrev(int n, int a[])`。
- b. 整数配列と整数値を渡し、指定した整数値が配列の何番に入っているかを返す (入っていなければ`-1`を返す) 関数`int iindex(int n, int a[], int x)`。
- c. 整数配列の最大値を返す関数`int maxiarray(int n, int a[])`。
- d. 整数配列の最小値を返す関数`int miniarray(int n, int a[])`。
- e. 整数配列の合計値を返す関数`int sumiarray(int n, int a[])`。
- f. 整数配列の平均値を返す関数`double avgiarray(int n, int a[])`。
- g. 実数配列の打ち出し/後ろから順に打ち出し/最大値/最小値/ 合計値/平均値を返す関数。
- h. 好きな方法で整数配列を整列する関数。-> クイックソートで整列させた。
- i. [自由課題] 第4回 演習 5の`perm`関数をC言語で実装してみた。

### 演習 2 配列の入力

次の関数を実装する。

- a. 最初に個数を指定してその数だけ入力する代わりに、順番に数値を入力して最後に `0`を入れると終わり、入力した個数 (`0`は含まない) を返す関数`int riarrayz(int lim, int a[])`。`lim`は最大個数で、それより多く入力してはいけない。
- b. 上記と同様だが、終わりの印になる数をパラメタで渡す`int riarrayz2(int lim, int a[], int endval)`。
- c. `riarray`、`riarrayz`、`riarrayz2`の実数入力版。
- d. [自由課題] 入力関数 -> 文字列から配列にキャストする`str2double_array`関数を実装した。
- e. [自由課題] その他ポインタやアドレスを使った面白いと思う関数。
 -> 演習2dを`malloc`関数を使用して実装した。

### 演習 3 動的計画法によるフィボナッチ数列

テキストで説明された方法で「`0`番目から`30`番目までのフィボナッチ数列を打ち出す」プログラムを作る。さらに、「`0`～`30`までのいずれかの番号を入力すると、その番号のフィボナッチ数列を出力する」プログラムも作る。

### 演習 4 部屋割り問題

テキストにある部屋割り問題を実行し、さらに「13 人部屋 3 万円」
「17 人部屋 4 万円」の選択肢を追加して動かす。

### 演習 5 釣り銭問題

金額を与えると、最小の米国紙幣貨幣数とその具体的な組み合わせを出力するプログラムを作成する。

### 演習 6 最長増加部分列

整数の列が与えられた時、その中から(とびとびに)後の方ほど値が大きくなるような部分列を選ぶとする。そのような部分列で最も長いもの (最長増加部分列、longest increasing subsequence)の長さ (できれば列自体も) を表示するプログラムを書く。

### 演習 7 [自由課題] ナップザック問題

AIZU ONLINE JUDGE ナップザック問題

http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_B&lang=jp

を動的計画法で解いた。(詳細については[実施したこととその結果]の項にて説明している。)

## [実施したこととその結果]

### 演習 1

演習1a～fについては、プログラム全体はこのような概形である。

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MEM 256

// 配列を文字列にする関数

char* int_array2str(char* str, int n, int* a) {
    char tmp[MEM];
    sprintf(str, "{%d", a[0]);
    for (int i = 1; i < n; i++) {
        sprintf(tmp, ", %d", a[i]);
        strcat(str, tmp);
    }
    strcat(str, "}");
    return str;
}

int main(void) {

    char str[MEM];

    int a[24] = {1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8};

    // ...
    // 各種処理
    // ...

    return 0;
}
```

なお、表示を行うために配列を文字列に変換する`int_array2str`関数も別途定義してある。

#### a pi_array_rev関数

実装部

```c
void pi_array_rev(int n, int* a) {
    for (int i = n-1; i >= 0; i--) {
        printf("%2d", a[i]);
        if ((n - i - 1) % 10 == 9) printf("\n");
    }
    printf("\n");
}
```

使用部

```c
pi_array_rev(24, a);
```

実行結果

```
 8 7 6 5 4 3 2 1 8 7
 6 5 4 3 2 1 8 7 6 5
 4 3 2 1
```

逆順に表示させるために、繰り返し変数を減らしていくという方法を取った。

#### b indexOf関数

実装部

```c
int indexOf(int n, int* a, int x) {
    for (int i = 0; i < n; i++) {
        if (a[i] == x) return i;
    }
    return -1;
}
```

使用部

```c
printf("5 is at %2d in a.\n", indexOf(24, a, 5));
printf("5 is at %2d in %s.\n", indexOf(3, a+2, 5), int_array2str(str, 3, a+2));
printf("9 is at %2d in a.\n", indexOf(24, a, 9));
printf("5 is at %2d in %s.\n", indexOf(3, a+5, 5), int_array2str(str, 3, a+5));
```

実行結果

```
5 is at  4 in a.
5 is at  2 in {3, 4, 5}.
9 is at -1 in a.
5 is at -1 in {6, 7, 8}.
```

多くの言語で`indexOf`という関数にあたるので関数名をそれにならった。`for`ループ内で見つかったらそのインデックスを返し、`for`ループ内で見つからなければなかったということなのでここで`-1`を返している。
\
Rubyなら複数入っているときはタプルを返したりなどできるが、C言語では難しいので断念した

#### c max_int_array関数

実装部

```c
int max_int_array(int n, int* a) {
    int m = a[0];
    for (int i = 1; i < n; i++) {
        if (m < a[i]) m = a[i];
    }

    return m;
}
```

使用部

```c
printf("%d is max of a.\n", max_int_array(24, a));
printf("%d is max of %s.\n", max_int_array(3, a+2), int_array2str(str, 3, a+2));
```

実行結果

```
8 is max of a.
5 is max of {3, 4, 5}.
```

Rubyと同じアルゴリズムで、大きいものが来たら取り換えるというようにして実装した。
\
なお、関数名についてだが、`maxiarray`ではわかりにくいので、スネークケースを用いて`max_int_array`とし単語の意味が分かるようにした。

#### d min_int_array関数

実装部

```c
int min_int_array(int n, int* a) {
    int m = a[0];
    for (int i = 1; i < n; i++) {
        if (m > a[i]) m = a[i];
    }

    return m;
}
```

使用部

```c
printf("%d is min of a.\n", min_int_array(24, a));
printf("%d is min of %s.\n", min_int_array(3, a+2), int_array2str(str, 3, a+2));
```

実行結果

```
1 is min of a.
3 is min of {3, 4, 5}.
```

`max_int_array`に関して符号を逆転させただけである。

#### e sum_int_array関数

実装部

```c
int sum_int_array(int n, int* a) {
    int sum = 0;
    for (int i = 0; i < n; i++) sum += a[i];
    return sum;
}
```

使用部

```c
printf("sum of a is %d.\n", sum_int_array(24, a));
printf("sum of %s is %d.\n", int_array2str(str, 3, a+2), sum_int_array(3, a+2));
```

実行結果

```
sum of a is 108.
sum of {3, 4, 5} is 12.
```

一時変数sumを`0`で初期化して`for`ループによって各配列の値を`sum`に足しただけである。
\
`sumiarray`も`max_int_array`と同様の改名を施した。

#### f avg_int_array関数

実装部

```c
double avg_int_array(int n, int* a) {
    return sum_int_array(n, a) / (double)n;
}
```

使用部

```c
printf("average of a is %lf.\n", avg_int_array(24, a));
printf("average of %s is %lf.\n", int_array2str(str, 3, a+2), avg_int_array(3, a+2));
```

実行結果

```
average of a is 4.500000.
average of {3, 4, 5} is 4.000000.
```

`sum_int_array`を`double`型でキャストした要素数で割ればそれは`double`型の平均である。
\
関数名の改名については同上。

#### g 実数配列

以下のように実装した。

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MEM 256

// 配列を文字列にする関数

char* double_array2str(char* str, int n, double* a) {
    char tmp[MEM];
    sprintf(str, "{%.1lf", a[0]);
    for (int i = 1; i < n; i++) {
        sprintf(tmp, ", %.1lf", a[i]);
        strcat(str, tmp);
    }
    strcat(str, "}");
    return str;
}

// 打ち出し

void pdarray(int n, double a[]) {
    int i;
    for (i = 0; i < n; ++i) {
        printf(" %.1lf", a[i]);
        if (i % 10 == 9 || i == n-1) printf("\n");
    }
}

// 逆順

void pd_array_rev(int n, double* a) {
    for (int i = n-1; i >= 0; i--) {
        printf(" %.1lf", a[i]);
        if ((n - i - 1) % 10 == 9) printf("\n");
    }
    printf("\n");
}

// 最大値

double max_double_array(int n, double* a) {
    double m = a[0];
    for (int i = 1; i < n; i++) {
        if (m < a[i]) m = a[i];
    }

    return m;
}

// 最小値

double min_double_array(int n, double* a) {
    double m = a[0];
    for (int i = 1; i < n; i++) {
        if (m > a[i]) m = a[i];
    }

    return m;
}

// 合計値

double sum_double_array(int n, double* a) {
    double sum = 0;
    for (int i = 0; i < n; i++) sum += a[i];
    return sum;
}

// 平均値

double avg_double_array(int n, double* a) {
    return sum_double_array(n, a) / (double)n;
}

int main(void) {

    char str[MEM];

    // ex
    double a[24];

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 8; j++) {
            a[i*8+j] = (double)(j+1);
        }
    }

    // 全体の表示

    printf("# show\n## all\n\n");
    pdarray(24, a);

    // 一部の表示

    printf("\n## parts\n### 1\n\n");
    pdarray(5, a+2);
    
    printf("\n### 2\n\n");    
    pdarray(8, a+8);

    // 逆順

    printf("\n# rev\n\n");
    pd_array_rev(24, a);

    // 最大値

    printf("\n# max\n\n%.1lf is max of a.\n", max_double_array(24, a));
    printf("%.1lf is max of %s.\n", max_double_array(3, a+2), double_array2str(str, 3, a+2));

    // 最小値

    printf("\n# min\n\n%.1lf is min of a.\n", min_double_array(24, a));
    printf("%.1lf is min of %s.\n", min_double_array(3, a+2), double_array2str(str, 3, a+2));

    // 合計

    printf("\n# sum\n\nsum of a is %.1lf.\n", sum_double_array(24, a));
    printf("sum of %s is %.1lf.\n", double_array2str(str, 3, a+2), sum_double_array(3, a+2));

    // 平均

    printf("\n# avg\n\naverage of a is %.1lf.\n", avg_double_array(24, a));
    printf("average of %s is %.1lf.\n", double_array2str(str, 3, a+2), avg_double_array(3, a+2));

    return 0;
}
```

実行結果は省略する。

ほぼ`int`を`double`に、フォーマット`%d`を`%.1lf`にそれぞれ書き換えただけである。

#### h クイックソート

配列のクイックソートを実装した。アルゴリズムはRubyで書いたものと同じである。

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

// swap

void swap(int* a, int i, int j) {
	int tmp = a[i];
	a[i] = a[j];
	a[j] = tmp;
}

// quick_sort

void quick_sort(int* a, int i, int j) {
	if (j <= i) return;

	int t = rand() * ((j - i) / RAND_MAX) + i;
	t = i <= t && t <= j ? t : i;
	swap(a, t, j);
	int pivot = a[j],
		s = i;
	for (int k = i; k < j; k++) {
		if (a[k] <= pivot) swap(a, s++, k);
	}
	swap(a, j, s);
	quick_sort(a, i, s-1);
	quick_sort(a, s+1, j);
}

int main(int argc, char const *argv[]) {

	char str[MEM];
    char *args,
        *arr_str;
	srand(10);

    int arr[MEM];
    int arr_num = 0;

    if (argc > 1) {
        for (int i = 1; i < argc; i++) arr[i-1] = atoi(argv[i]);
        arr_num = argc-1;
    } else {
	    args = input(str, "array?\na b c ...(MAX 256) : ");
        arr_str = strtok(args, " ");
        for (; arr_str != NULL && arr_num < MEM; arr_num++) {
            arr[arr_num] = atoi(arr_str);
            arr_str = strtok(NULL, " ");
        }
    }

    quick_sort(arr, 0, arr_num-1);
    for (int i = 0; i < arr_num; i++) printf(" %d", arr[i]);
    printf("\n");
}
```

実行結果

```
$ ./prac1h
array?
a b c ...(MAX 256) : 4 8 9 5 2 5 6
 2 4 5 5 6 8 9

$ ./prac1h 7 2 4 5 8 3 4 8 5 3 9
 2 3 3 4 4 5 5 7 8 8 9
```

C言語では

- `rand`関数の範囲は`0 ~ RAND_MAX`までである
- `swap`関数を用意しなければならない

という注意点があることを踏まえた。

#### i perm関数

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MEM 256

void perm(int n, char *a, int a_len, char *str) {

    if (n == 0) {
        printf("%s\n", str);
        return;
    }

    for (int i = 0; i < a_len; i++) {
        if (a[i] == '\0') continue;
        char tmp[] = {a[i], '\0'};
        strcat(str, tmp);
        a[i] = '\0';
        perm(n-1, a, a_len, str);
        // printf("%d\n", n-1);
        for (int j = 0; str[j] != '\0'; j++) {
            if (str[j+1] == '\0') str[j] = '\0';
        }
        a[i] = tmp[0];
    }
}

int main(int argc, char const *argv[]) {
    char mem[MEM],
        a[] = "hoge";
    perm(3, a, 4, mem);
    return 0;
}
```

実行結果

```
hog
hoe

~~ 省略 ~~

egh
ego
```

Rubyと異なり、配列(文字列)が長さを保持していなかったり、最後の一文字を削除するのにも`for`文が必要であったりするために、少し長いコードとなった。

文字配列の例のように、C言語の配列は挿入や要素の削除がしにくいということがわかる。

### 演習 2

演習2a~eについて以下の部分は共通である。

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	// char str[MEM];
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

// ここに各演習にて定義
```

`main`関数の内部に関しては異なる。

#### a read_int_array_zero関数

```c
int read_int_array_zero(int lim, int *a) {
    char str[MEM],
        frmt[MEM]; // format
    int n;

    for (n = 0; n < lim; n++) {
        sprintf(frmt, "%d> ", n+1);
        a[n] = atoi(input(str, frmt));
        if (a[n] == 0) break;
    }

    return n;
}
```

`main`関数↓

```c
int main(void) {
    int a[MEM];

    printf("%d\n", read_int_array_zero(MEM, a));

    return 0;
}
```

実行例

```
$ ./prac2a
1> 21
2> 31
3> 0
2
```

`for`文により`a[n]`に随時`atoi(input(...))`の返り値を代入していく形で実現した。
\
`for`ループを抜ける際の`n`の値が配列の要素数に等しく、`3`を返している。
\
関数名について、各単語に意味を持たせスネークケースとなるように改変した。(以下同様。)

#### b read_int_array_zero2関数

```c
int read_int_array_zero2(int lim, int *a, int endval) {
    char str[MEM],
        frmt[MEM]; // format
    int n;

    for (n = 0; n < lim; n++) {
        sprintf(frmt, "input integer (%d for end) %d> ", endval, n+1);
        a[n] = atoi(input(str, frmt));
        if (a[n] == endval) break;
    }

    return n;
}
```

`main`関数↓

```c
int main(void) {
    int a[MEM];
    char str[MEM];
    int endval;

    endval = atoi(input(str, "endval> "));
    printf("%d\n", read_int_array_zero2(MEM, a, endval));

    return 0;
}
```

実行例

```
$ ./prac2b
endval> -1
input integer (-1 for end) 1> 41
input integer (-1 for end) 2> 0
input integer (-1 for end) 3> -1
2
```

代入部分は`read_int_array_zero`関数と変わらない。最後の入力であるかの比較についてのみ引数`endval`と比較させるように変えた。

#### c 実数入力版

```c
void pdarray(int n, double a[]) {
    int i;
    for(i = 0; i < n; ++i) {
        printf(" %lf", a[i]);
        if(i % 10 == 9 || i == n-1) { printf("\n"); }
    }
}

void rdarray(int n, double a[]) {
    char str[MEM],
        frmt[MEM]; // format

    int i;
    for(i = 0; i < n; ++i) {
        // printf("%d> ", i+1); scanf("%lf", a+i); // &a[i] でも OK
        sprintf(frmt, "%d> ", i+1);
        a[i] = atof(input(str, frmt));
    }
}

int read_double_array_zero(int lim, double *a) {
    char str[MEM],
        frmt[MEM]; // format
    int n;

    for (n = 0; n < lim; n++) {
        sprintf(frmt, "%d> ", n+1);
        a[n] = atof(input(str, frmt));
        if (a[n] == 0) break;
    }

    return n;
}

int read_double_array_zero2(int lim, double *a, double endval) {
    char str[MEM],
        frmt[MEM]; // format
    int n;

    for (n = 0; n < lim; n++) {
        sprintf(frmt, "input double (%lf for end) %d> ", endval, n+1);
        a[n] = atof(input(str, frmt));
        if (a[n] == endval) break;
    }

    return n;
}
```

```c
int main(void) {
    int n;
    double a[MEM];
    char str[MEM];
    int endval;

    // printf("n> "); scanf("%d", &n);
    n = atoi(input(str, "n> "));
    rdarray(n, a); pdarray(n, a);

    printf("%d\n", read_double_array_zero(MEM, a));

    endval = atof(input(str, "endval> "));
    printf("%d\n", read_double_array_zero2(MEM, a, endval));

    return 0;
}
```

演習1同様、`int`を`double`に、`%d`を`%lf`に変え、関数名を適当なものへと変更しただけである。(`pdarray`、`rdarray`は例題の`piarray`、`riarray`と対になるようにしたためあえて大規模には変えなかった)
\
結果は省略する。

#### d str2double_array関数

実行に際し演習1で作成した関数などを使用している。

```c
int str2double_array(char *str, double *arr, int max_len) {
    int n;
    char *tmp;

    tmp = strtok(str, " ,");
    if (!tmp) return 0;
    arr[0] = atof(tmp);
    for (n = 1; n < max_len; n++) {
        tmp = strtok(NULL, " ,");
        if (!tmp) break;

        arr[n] = atof(tmp);
    }

    return n;
}
```

`main`関数↓

```c
int main(int argc, char const *argv[]) {
    char str[MEM];
    double arr[MEM];
    int arr_len = 0;

    if (argc > 1) {
        int i = 0;
        for (i = 0; i+1 < argc && i < MEM; i++) {
            arr[i] = atof(argv[i+1]);
        }
        arr_len = i;
    } else {
        arr_len = str2double_array(input(str, "val, val, ...\n: "), arr, MEM);
    }

    pdarray(arr_len, arr);
    printf("MAX : %lf\n", max_double_array(arr_len, arr));
    printf("min : %lf\n", min_double_array(arr_len, arr));
    printf("sum : %lf\n", sum_double_array(arr_len, arr));
    printf("avg : %lf\n", avg_double_array(arr_len, arr));

    return 0;
}
```

実行例

```
$ ./prac2d
val, val, ...
: 9 3 4 7 5 2 9 5 7 10
 9.0 3.0 4.0 7.0 5.0 2.0 9.0 5.0 7.0 10.0
MAX : 10.000000
min : 2.000000
sum : 61.000000
avg : 6.100000
```

`9 3 4 7 5 2 9 5 7 10`といった文字列を配列の入力として受け取る`str2double_array`関数を実装した。

引数は
- 入力に当たる文字列`str`
- 配列のポインタ`arr`(予めメモリは確保されている)
- 予め確保しておいた領域を示す`max_len`

であり、返り値として配列の要素数`n`を返す。

文字列のスペースによる分割(他言語では`split`メソッドなどとして実装されている)には`string.h`に含まれる`strtok`関数を使用した。
\
最初に第一引数に文字列を渡し、その後は`NULL`を渡すことで、第二引数に指定した文字列内の文字で区切りその返り値として区切られた文字列のポインタを返すので、それを`tmp`で受け取っている。
\
`tmp`変数が`NULL`となるときは入力の終わりなので返り値`n`を渡して終わる。`tmp`を`stdlib.h`に含まれる関数`atof`によって実数にすることで配列に代入できる形とした。

#### e malloc関数を使用した実装

演習2dの内容に関して、上限というものをなくすために動的に配列を生成するように仕様変更を施した。
\
dと同じく実行に際し演習1で作成した関数などを使用している。

```c
int str2double_array(char *str, double **arr) {
    int n = 1;
    char *tmp;
    char str_cpy[MEM];

    strcpy(str_cpy, str);

    if (!strtok(str_cpy, " ,")) return 0;
    while (strtok(NULL, " ,")) n++;

    *arr = (double *)malloc( sizeof(double) * n );

    tmp = strtok(str, " ,");
    // if (!tmp) return 0;
    (*arr)[0] = atof(tmp);
    for (int i = 1; i < n; i++) {
        tmp = strtok(NULL, " ,");
        if (!tmp) break;

        (*arr)[i] = atof(tmp);
    }

    return n;
}
```

`main`関数↓

```c
int main(int argc, char const *argv[]) {
    char str[MEM];
    // double arr[MEM];
    double *arr;
    int arr_len = 0;

    if (argc > 1) {
        arr = (double *)malloc( sizeof(double) * (argc-1) );

        for (int i = 0; i+1 < argc; i++) {
            arr[i] = atof(argv[i+1]);
        }
        arr_len = argc-1;

    } else {
        // arr_len = str2double_array(input(str, "val, val, ...\n: "), arr, MEM);
        arr_len = str2double_array(input(str, "val, val, ...\n: "), &arr);
    }

    pdarray(arr_len, arr);
    printf("MAX : %lf\n", max_double_array(arr_len, arr));
    printf("min : %lf\n", min_double_array(arr_len, arr));
    printf("sum : %lf\n", sum_double_array(arr_len, arr));
    printf("avg : %lf\n", avg_double_array(arr_len, arr));

    free(arr);

    return 0;
}
```

実行例は演習2dと同じであるため省略する。

引数として最大値`max_len`を取らなくてよくなった点、`maolloc`関数で確保したメモリを開放する関数`free`を呼び出す必要がある点以外に特に大きな変更点はない。

ただし利便性を考えると別に向上しているわけではないので、`free`関数を呼び出さなくて済むという汎用性を考えると、演習1dのように予め最大値を決めて領域を確保するほうが無難であるといえる。

### 演習 3 動的計画法によるフィボナッチ数列

全体のプログラムは以下のようになった。部分的に解説していく。

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

int main(int argc, char const *argv[]) {
    int i,
        fib[31] = { 1, 1 };

    for (int i = 0; i < 2; i++) printf("%d : %d\n", i, fib[i]);

    for (i = 2; i <= 30; i++) {
        fib[i] = fib[i-1] + fib[i-2];
        printf("%d : %d\n", i, fib[i]);
    }

    printf("\n");

    int res = 0,
        tmp = 0;

    if (argc > 1) {
        tmp = atoi(argv[1]);
        res = 0 <= tmp && tmp <= 30 ? fib[tmp] : -1;
    } else {
        char str[MEM];
        tmp = atoi(input(str, "0 ~ 30 : "));
        res = 0 <= tmp && tmp <= 30 ? fib[tmp] : -1;        
    }

    printf("%d : %d", tmp, res);
}
```

実行例

```
$ ./prac3
0 : 1
1 : 1

~~ 省略 ~~

29 : 832040
30 : 1346269

0 ~ 30 : 5
5 : 8
```

#### 動的計画法による計算

`main`関数冒頭の以下に示す範囲にて`fib[0]`、`fib[1]`の表示と動的計画法による計算を行っている。(計算だけする分には最初の`for`文は不要である。)

`fib[i] = fib[i-1] + fib[i-2];`が計算されるときにはすでに`fib[i-1]`、`fib[i-2]`は求まっている。これが動的計画法の基本的な考えである。

```c
int i,
    fib[31] = { 1, 1 };

for (int i = 0; i < 2; i++) printf("%d : %d\n", i, fib[i]);

for (i = 2; i <= 30; i++) {
    fib[i] = fib[i-1] + fib[i-2];
    printf("%d : %d\n", i, fib[i]);
}
```

#### 入力した対象番号に対する出力

以下ではコマンドライン引数または標準入力より整数`tmp`を受け取り、`tmp`が範囲内であれば`fib[tmp]`を、そうでなければ`-1`を解として`res`に代入し、表示するということを行っている。

```c
int res = 0,
    tmp = 0;

if (argc > 1) {
    tmp = atoi(argv[1]);
    res = 0 <= tmp && tmp <= 30 ? fib[tmp] : -1;
} else {
    char str[MEM];
    tmp = atoi(input(str, "0 ~ 30 : "));
    res = 0 <= tmp && tmp <= 30 ? fib[tmp] : -1;        
}

printf("%d : %d", tmp, res);
```

### 演習 4 部屋割り問題

テキストにある通りに打ち込んで動いたので全コードの掲載は控える。
\
部屋の選択肢の追加は、`initialize`関数内部の`for`ループ内の`if`文として、以下の二つを`if(min > room1(i-7) + 20000) { min = room1(i-7) + 20000; sel = 7; }`と`roomprice[i] = min; roomsel[i] = sel;`の間に挟めるだけである。

```c
if(min > room1(i-13) + 30000) { min = room1(i-13) + 30000; sel = 13; }
if(min > room1(i-17) + 40000) { min = room1(i-17) + 40000; sel = 17; }
```

### 演習 5 釣り銭問題

演習4のテキストのコードに習い`initialize`関数を用いて以下のように実装した。
\
順を追って解説していく。

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MAX_MEM 65536
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

int coins_num[MAX_MEM] = { 0, };
int coins_select[MAX_MEM] = { 0, };

int coins_kind[] = {1, 5, 10, 25, 50, 100, 1000};
int coins_kind_len = 7;

int coin_getter(int c) {
    return c >= 0 ? coins_num[c] : -1;
}

void initialize(void) {
    for (int i = 1; i < MAX_MEM; i++) {
        int
            min = coin_getter(i - coins_kind[0]),
            select = coins_kind[0],
            next = 0;
        for (int j = 1; j < coins_kind_len; j++) {
            next = coin_getter(i - coins_kind[j]);
            if (min > next && next >= 0) {
                min = next;
                select = coins_kind[j];
            }
        }
        coins_num[i] = min + 1;
        coins_select[i] = select;
    }
}

int main(void) {
    char str[MEM];
    int
        change = 0,
        c_num = 0,
        tmp = 0;
        // sum = 0;

    initialize();
    
    while (1) {
        // sum = 0;
        change = atoi(input(str, "change? (0 for end)\n: "));
        
        // 例外処理
        if (change == 0) {
            return 0;
        } else if (change < 0 || change >= MAX_MEM) {
            printf("invalid change. please 0 ~ %d\n", MAX_MEM-1);
            continue;
        }

        printf("coins : ");

        tmp = change;
        while (tmp > 0) {
            // sum += coins_select[tmp];
            printf(" %2d", coins_select[tmp]);
            tmp -= coins_select[tmp];
        }
        printf("\n");

        printf("coins_num : %d\n", coins_num[change]);
        // printf("sum : %d\n", sum);
    }

    return 0;
}
```

実行例

```
$ ./prac5
change? (0 for end)
: 1234
coins :   1  1  1  1  5 25 100 100 1000
coins_num : 9
change? (0 for end)
: 5678
coins :   1  1  1 25 50 100 100 100 100 100 100 1000 1000 1000 1000 1000
coins_num : 16
change? (0 for end)
: 1100
coins :  100 1000
coins_num : 2
change? (0 for end)
: 0
```

#### 各種グローバル変数、配列

```c
int coins_num[MAX_MEM] = { 0, };
int coins_select[MAX_MEM] = { 0, };

int coins_kind[] = {1, 5, 10, 25, 50, 100, 1000};
int coins_kind_len = 7;

int coin_getter(int c) {
    return c >= 0 ? coins_num[c] : 0;
}
```

`coins_num`は動的計画法のメモ用配列、`coins_select`はトレースバックにあたり、`coins_kind`は硬貨(だけでは高額のとき出力量が多くなってしまったので、紙幣を加えている。)の種類、`coins_kind_len`は硬貨紙幣の種類数にあたる。

なお、`coin_getter`は動的計画法がうまく動作するように使用する`coins_num`のゲッターとなっているが、実際は`initialize関数`内に`next >= 0`という条件があるためゲッターがなくとも動作する。演習4に合わせるために今回は導入した。

#### 初期化(initialize)関数

`initialize`関数内で動的計画法の計算を行う。
\
外側の`for`ループの`i`は与えれらる金額であり、1つの紙幣貨幣で最も金額を減らせる紙幣貨幣を選んだ場合の価格が`min`に入るように最小値を探していく。

紙幣硬貨の種類が増えても配列部分のみを変更するだけで済むように、演習4における条件分岐地帯を内側の`for`文とした。

またこの時に選んだ紙幣貨幣をトレースバックとして`select`変数に入れ、のちに保存している。

```c
void initialize(void) {
    for (int i = 1; i < MAX_MEM; i++) {
        int
            min = coin_getter(i - coins_kind[0]),
            select = coins_kind[0],
            next = 0;
        for (int j = 1; j < coins_kind_len; j++) {
            next = coin_getter(i - coins_kind[j]);
            if (min > next && next > 0) {
                min = next;
                select = coins_kind[j];
            }
        }
        coins_num[i] = min + 1;
        coins_select[i] = select;
    }
}
```

#### main関数

`initialize`関数を実行後、お釣りを受け取る変数`change`の値に従って条件分岐を行い、計算した値を表示していく。`tmp`変数はトレースバック -> 枚数という順で出力を行いたかったために用意した。またコメントアウトしてある`sum`変数は合計値が正しいかを計算するためのものである。

```c
int main(void) {
    char str[MEM];
    int
        change = 0,
        tmp = 0;
        // sum = 0;

    initialize();
    
    while (1) {
        // sum = 0;
        change = atoi(input(str, "change? (0 for end)\n: "));
        
        // 例外処理
        if (change == 0) {
            return 0;
        } else if (change < 0 || change >= MAX_MEM) {
            printf("invalid change. please 0 ~ %d\n", MAX_MEM-1);
            continue;
        }

        printf("coins : ");

        tmp = change;
        while (tmp > 0) {
            // sum += coins_select[tmp];
            printf(" %2d", coins_select[tmp]);
            tmp -= coins_select[tmp];
        }
        printf("\n");

        printf("coins_num : %d\n", coins_num[change]);
        // printf("sum : %d\n", sum);
    }

    return 0;
}
```

### 演習 6 最長増加部分列問題

演習6に関しても演習4、演習5に習った実装を行った。
\
今回はメモ配列`maxLen`に各位置における最大長を、トレースバックに前のインデックスを記録させるようにした。

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

int
    maxLen[MEM] = { 1, }, // 最大長を記憶しておく配列
    maxLen_pre_indexs[MEM] = { -1, }, // トレースバック
    arr_len_global = 0;

// int maxLen_getter(int i, int arr_len) {
// 最大長のゲッター
int maxLen_getter(int i) {
    // return i >= 0 ? maxLen[i] : 0;
    if (i < 0) {
        return 0;
    } else if (arr_len_global <= i) {
        return maxLen[arr_len_global-1];
    } else {
        return maxLen[i];
    }
}

void initialize(int *arr, int arr_len) {
    for (int i = 1; i < arr_len; i++) {
        int
            // max = arr[i] > arr[0] ? maxLen_getter(0) : 0,
            max = 0,
            pre_index = -1,
            next = 0; // 一時変数
        
        arr_len_global = arr_len;

        for (int j = 0; j < i; j++) {
            next = arr[i] > arr[j] ? maxLen_getter(j) : 0;
            // printf("%d %d\n", i, next);
            if (next > max) {
                max = next;
                pre_index = j;
            }
        }
        maxLen[i] = max + 1;
        maxLen_pre_indexs[i] = pre_index;
    }
}

int main(int argc, char const *argv[]) {
    int arr[MEM],
        arr_len = 0;

    // 入力
    if (argc > 1) {
        for (arr_len = 0; arr_len < argc-1 && arr_len < MEM; arr_len++) {
            arr[arr_len] = atoi(argv[arr_len+1]);
        }
    } else {
        char
            str[MEM],
            *tmp;
        
        tmp = strtok(input(str, "array ? : "), " ,");
        for (arr_len = 0; arr_len < MEM && tmp; arr_len++) {
            arr[arr_len] = atoi(tmp);
            tmp = strtok(NULL, " ,");
        }
    }

    // for (int i = 0; i < arr_len; i++) printf("%d ", arr[i]);
    // printf("\n");

    // 初期化
    initialize(arr, arr_len);

    // 最大のものを求める
    int
        max = 0,
        last_index = 0;
    for (int i = 0; i < arr_len; i++) {
        if (maxLen_getter(i) > max) {
            max = maxLen_getter(i);
            last_index = i;
        }
    }

    // 出力
    // 長さ
    printf("len = %d\nselect : ", max);

    // 選択した数字
    int
        tmp_arr[MEM],
        i = 0;

    while (last_index >= 0) {
        tmp_arr[i++] = arr[last_index];
        last_index = maxLen_pre_indexs[last_index];
    }

    for (int j = i-1; j >= 0; j--) printf("%d ", tmp_arr[j]);
    printf("\n");

    return 0;
}
```

実行例

```
$ ./prac6
array ? : 1 5 7 2 6 3 4 9
len = 5
select : 1 2 3 4 9
```

### 演習 7 ナップザック問題

---

AIZU ONLINE JUDGE ナップザック問題

http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_B&lang=jp

0-1 ナップザック問題

価値が`vi`重さが`wi`であるような`N`個の品物と、容量が`W`のナップザックがあります。次の条件を満たすように、品物を選んでナップザックに入れます：

選んだ品物の価値の合計をできるだけ高くする。
選んだ品物の重さの総和は`W`を超えない。
価値の合計の最大値を求めてください。

入力
１行目に２つの整数`N`、`W`が空白区切りで１行に与えられます。 続く`N`行で`i`番目の品物の価値`vi`と重さ`wi`が空白区切りで与えられます。

出力
価値の合計の最大値を`1`行に出力してください。

---

この問題を動的計画法で解いた。以下が解法コードである。

```c
#include <stdio.h>
#include <stdlib.h>
#define MEM 110

int max2(int a, int b) {
    return a > b ? a : b;
}

int main(void) {

    // 入力

    int N, W;
    scanf("%d %d", &N, &W);

    int
        v_arr[MEM],
        w_arr[MEM];

    for (int i = 0; i < N; i++) scanf("%d %d", &v_arr[i], &w_arr[i]);

    // 計算

    int* max_values[MEM];
    
    for (int i = 0; i < MEM; i++) {
        max_values[i] = (int *)calloc( W+1, sizeof(int) );
        // max_values[i+1][w] := i番目までの品物から重さがwを超えないように選んだ時の価値の総和の最大値
    }

    // 初期化: 0番目のときの-1番目に関する価値 -> 全て0
    for (int w = 0; w <= W; w++) max_values[0][w] = 0; 

    for (int i = 0; i < N; i++) {
        for (int w = 0; w <= W; w++) {
            if (w >= w_arr[i]) {
                max_values[i+1][w] = max2( max_values[i][w - w_arr[i]] + v_arr[i], max_values[i][w] );
                // この商品を取った時の価値と取らずにwまで取った時の最大値を比べる。
            } else {
                max_values[i+1][w] = max_values[i][w];
                // この商品はもう取れないので取らなかったときの値が最大
            }
        }
    }

    // 出力
    printf("%d\n", max_values[N][W]);

    for (int i = 0; i < MEM; i++) {
        free(max_values[i]);
    }

    return 0;
}
```

実行例

```
$ ./prac7
4 5
4 2
5 2
2 1
8 3
13
```

計算部から説明していく。今回の問題を解くにあたり2次配列`max_values`を用いた。
\
今回の問題にて、予め`max_values[100][10000]`(`N`、`W`の各最大値)を確保しようとすると`Segmentation fault`(配列の確保に失敗)となってしまったため、動的にメモリを確保した。

`W`から逆算して途中の重さを求めていくことは不可能なので、代わりに`max_values[i+1][w]`には、`i`番目(`i+1`番目ではない。)に重さ`w`以下で取れる最大の価値が代入されるように計算していく、という方針である。

これを計算しつくした状態で、`max_values[N][W]`が求める価値の最大値となる。

各計算についてはソースコード内におけるコメントに詳しい。

こういった複数の項目を保存しながら解くということも動的計画法では可能であることがわかった。

## [考察]

配列の正体がポインタであることは以前から知っていたが、今回配列に関連したコードを書く過程で今まで気づけなかったことにも気づけた。

その一つがまずメモリを確保しているか否かについてである。C言語の危ない点は、関数ではそのポインタからどこまでがプログラム全体で割り当てられているかがわからないことにある。したがってコンパイルは通るものの、「範囲外アクセス」により実行時エラー(`Segmentation fault`)となってしまうということを複数繰り返してしまった。

もう一つは、上記に関連して次の書き方はエラーとなることである。

```c
int a[] = {1, 2, 3, 4};
a = a+1;
```

```
$ gcc hoge.c
hoge.c: In function 'main':
hoge.c:5:7: error: assignment to expression with array type
     a = a+1;
       ^
```

すなわち、「配列とポインタは別」なのである。ポインタとメモリ領域の確保を組み合わせたものが配列ではあるものの、(それはおそらく一種のシンタックスシュガーであるために)ポインタと同一の振る舞いをするわけではない。(ちなみに`malloc`関数や`calloc`関数で同様のことを行った場合はエラーにはならない。)

つまり以上より、C言語における配列の正体が「ポインタとメモリ」であることとともに、「配列とポインタは全く同一というわけではない」という意識も持ち合わせている必要があるのだと考えられる。

さらには、ポインタへの理解ももう少し深めていきたい。しかし、他の言語ではポインタというものが存在しないことからも言えるのは、ポインタ自体はやはり危険な操作を行ってしまう可能性があるため利用はなるべく避けたいものである、ということである。

可読性を失わない範囲でポインタを使っていきたい。

## [アンケート]

- Q1. C言語で配列を取り扱えるようになりましたか。

ええ、まぁ。

- Q2. 動的計画法を理解しましたか。またどのように思いましたか。

書きどころがなかなかつかめないですね。。ナップザック問題も初見では難しかったです。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

動的計画法に関しては他の言語でもやってみたいと思います。C言語の配列はクセが強く(もとい機能が少なく)、使い方や使いどころが試されるように思われます。次回も頑張ります！