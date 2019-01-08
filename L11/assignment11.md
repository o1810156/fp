# 基礎プログラミングおよび演習レポート #11

学籍番号: 1810156
\
氏名: ** ***
\
ペア学籍番号・氏名(または「個人作業」): 個人作業
\
提出日付: 2019/1/8

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L11/assignment11.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- `~~ 省略 ~~`として一部実行結果を省略している箇所があります。

## [課題の再掲]

### 演習 1 基本的なC言語プログラム

- a. 円錐の底面の半径と高さを与え、体積を出力する。
- b. 実数`x`を与え、その平方値を出力する。
- c. 実数`x`を与え、その`8`乗 (または`7`乗または`6`乗) を出力する。
- d. 整数を`2`つ与え、その大きい方を出力する。
- e. 整数を`2`つ与え、その小さい方を出力する。
- f. 整数を`3`つ与え、その最大値を出力する (または`4`つの最大でもよい)。
- g. 整数を`3`つ与え、その最小値を出力する (または`4`つの最小でもよい)。
- h. 整数を`3`つ与え (すべて異なる値とする)、中央の値を出力する。
- i. 正の整数`n`を与え、`n`の階乗を出力する。
- j. 正の整数`n`を与え、`2 ^ n`を出力する。
- k. 正の整数`n`, `r`(`n ≥ r`) を与え、`nCr`を出力する。
- l. 正の整数`a`, `b`を与え、それらの最大公約数を出力する。
- m. その他、自分が面白いと思う計算を行う関数を作って行なう。 -> 平均値と標準偏差の打ち出し

### 演習 2 繰り返しを使用したC言語プログラム

- a. `1`から最大値までの数を順に打ち出すが、`3`の倍数または`3`がつく数のときはかりに`aho`と打ち出す (ナベアツ)。
- b. `1`から`99`までの数を順に打ち出すが、`3`の倍数なら`fizz`、`5`の倍数なら `buzz`、両方の倍数なら`fizzbuzz`を数の代わりに打ち出す (`fizzbuzz`問題)。
- c. 正の整数`n`を受け取り、`n`以下の素数を順に打ち出す
- d. 正の整数`n`を受け取り、`n`から`1`までを`1`つずつ小さくなる順に打ち出す。
- e. 正の整数`n`を受け取り、`0 1 0 1…`と交互に`n`個打ち出す。
- f. 正の整数`n`を受け取り、`1 0 1 0…`と交互に`n`個打ち出す。
- g. 正の整数`n`を受け取り、`1, 3, 9, 27, … 3^n`を打ち出す。
- h. 九九の表を打ち出す。
- i. その他、自分の面白いと思う計算をループを使って行なう。 -> 円周率の数値計算

### 演習 3 数え上げ法

数え上げ法によって平方根を求めるCプログラムを作成する。

### 演習 4 区間2分法

区間2分法によって平方根を求めるCプログラムを作成する。

### 演習 5 ニュートン法

ニュートン法によって平方根を求めるCプログラムを作成する。

### 演習 6 [自由課題] C言語によるクワイン

自分自身を出力するプログラムを作成した。

## [実施したこととその結果]

### 演習 1

ファイルの数を減らしたいという都合上、a ～ mそれぞれの関数を定義して、`main`関数内で一度に実行するという形をとった。

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

// a cone関数

double cone(double r, double h) {
	return (M_PI * r * r) * h / 3.0;
}

// d max2関数

int max2(int n, int m) {
	return n > m ? n : m;
}

// e min2関数

int min2(int n, int m) {
	return n < m ? n : m;
}

// f max_in_arr関数

int max_in_arr(int* arr, int numbers_num) {
	int max = arr[0];
	for (int i = 1; i < numbers_num; i++) {
		if (max < arr[i]) max = arr[i];
	}
	return max;
}

// g min_in_arr関数

int min_in_arr(int* arr, int numbers_num) {
	int min = arr[0];
	for (int i = 1; i < numbers_num; i++) {
		if (min > arr[i]) min = arr[i];
	}
	return min;
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

// h mean_of_arr関数

double mean_of_arr(int* arr, int numbers_num) {
	int b[MEM];
	for (int i = 0; i < numbers_num; i++) b[i] = arr[i];
	quick_sort(b, 0, numbers_num-1);

	if (numbers_num % 2 == 1) {
		return (float)b[numbers_num / 2];
	} else if (numbers_num > 0) {
		int m = numbers_num / 2;
		return (float)(b[m-1] + b[m]) / 2.0;
	} else {
		return 0;
	}
}

// 今回は再帰で定義

// i factorial関数

int factorial(int n) {
	return n > 0 ? n * factorial(n - 1) : 1;
}

// k combination関数

int combination(int n, int r) {
	if (r == 0 || r == n) {
		return 1;
	} else {
		return combination(n - 1, r) + combination(n - 1, r - 1);
	}
}

// l gcd関数

int gcd(int n, int m) {
	if (n == m) {
		return n;
	} else if (n > m) {
		return m != 0 ? gcd(n % m, m) : n;
	} else {
		return n != 0 ? gcd(m % n, n) : m;
	}
}

// m ave関数

double ave(int* arr, int num) {
	int sum = 0;
	for (int i = 0; i < num; i++) sum += arr[i];
	return sum / (double)num;
}

// m std_dev関数

double std_dev(int* arr, int num) {
	double av = ave(arr, num),
	       sum = 0;
	for (int i = 0; i < num; i++) {
		sum += pow(arr[i] - av, 2);
	}
	return sum / (double)num;
}

int main(void) {

    // 前処理
	char str[MEM];
	srand(10);

	// a
	printf("# prac 1\n## a\n");
	double r = atof(input(str, "r : "));
	double h = atof(input(str, "h : "));
	printf("cone V = %.3f\n", cone(r, h));

	// b
	double x = atof(input(str, "## b\nx : "));
	printf("sqrt(%.3f) = %.3f\n", x, sqrt(x));

	// c
	x = atof(input(str, "## c\nx : "));
	int n = atoi(input(str, "n : "));
	printf("%.3f^%d = %.3f\n", x, n, pow(x, n));

	// d
	char *n_m = input(str, "## d\nn m : ");
	n = atoi(strtok(n_m, " "));
	int m = atoi(strtok(NULL, " "));
	printf("lagger : %d\n", max2(n, m));

	// e
	n_m = input(str, "## e\nn m : ");
	n = atoi(strtok(n_m, " "));
	m = atoi(strtok(NULL, " "));
	printf("smaller : %d\n", min2(n, m));

	// f
	char *args = input(str, "## f\na b c ...(MAX 256) : ");
	int numbers[MEM];
	int numbers_num = 0;
	char *number_str = strtok(args, " ");
	for (; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}

	printf("largest : %d\n", max_in_arr(numbers, numbers_num));

	// g
	args = input(str, "## g\na b c ...(MAX 256) : ");
	numbers_num = 0;
	number_str = strtok(args, " ");
	for (; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}

	printf("smallest : %d\n", min_in_arr(numbers, numbers_num));

	// quick_sort test
	/*
	int a[5] = {4, 2, 6, 7, 3};
	quick_sort(a, 0, 4);
	for (int i = 0; i < 5; i++) printf("%d ", a[i]);
	printf("\n");
	*/

	// h 3つバージョン
	args = input(str, "## h(3)\na b c : ");
	number_str = strtok(args, " ");
	for(int i = 0; i < 3; i++) {
		numbers[i] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}
	printf("mean : %d\n", (int)mean_of_arr(numbers, 3));

	// h 複数バージョン
	args = input(str, "## h(n)\na b c ...(MAX 256) : ");
	numbers_num = 0;
	number_str = strtok(args, " ");
	for(; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}
	printf("mean : %.1f\n", mean_of_arr(numbers, numbers_num));

	// i
	n = atoi(input(str, "## i\nn : "));
	printf("%d! = %d\n", n, factorial(n));

	// j
	n = atoi(input(str, "## j\nn : "));
	printf("2^%d = %d\n", n, (int)pow(2, n));

	// k
	n = atoi(input(str, "## k\nn : "));
	int r2 = atoi(input(str, "r : "));
	printf("%dC%d = %d\n", n, r2, combination(n, r2));

	// gcd test
	// printf("gcd(%d, %d) = %d\n", 60, 18, gcd(60, 18));

	// l
	n_m = input(str, "## l\nn m : ");
	n = atoi(strtok(n_m, " "));
	m = atoi(strtok(NULL, " "));
	printf("gcd(%d, %d) = %d\n", n, m, gcd(n, m));

	// m 平均値と標準偏差を打ち出す
	args = input(str, "## m\na b c ...(MAX 256) : ");
	numbers_num = 0;
	number_str = strtok(args, " ");
	for(; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}
	printf("ave : %.2f\nstd_dev : %.2f\n", ave(numbers, numbers_num), std_dev(numbers, numbers_num));

	return 0;
}
```

`input`関数は、`scanf`関数だと入力ミスがあった際の挙動が想定できないため、安全に入力を受け取るために定義した。

Pythonの`input`関数のように、引数にプロンプト文字列を取り、文字列を返すという形を取っている。こうすることで可読性も向上させた。整数値は`atoi`関数、実数値は`atof`関数を使用することでそれぞれ文字列からキャストしている。

`swap`関数は配列とインデックスを受け取り要素を交換する関数であり、Rubyで扱ったものとほぼ同じである。

そのほか、特に難しい点もないためコードごとの解説は省略する。

以下入出力例である。

```
$ ./prac1
# prac 1
## a
r : 5
h : 5
cone V = 130.900
## b
x : 2
sqrt(2.000) = 1.414
## c
x : 5
n : 8
5.000^8 = 390625.000
## d
n m : 1 2
lagger : 2
## e
n m : 1 2
smaller : 1
## f
a b c ...(MAX 256) : 1 2 3 4 9 8 0 10 -1
largest : 10
## g
a b c ...(MAX 256) : 1 2 3 4 9 8 0 10 -1
smallest : -1
## h(3)
a b c : 3 9 7
mean : 7
## h(n)
a b c ...(MAX 256) : 1 2 3 4 9 8 0 10 -1
mean : 3.0
## i
n : 5
5! = 120
## j
n : 10
2^10 = 1024
## k
n : 5
r : 3
5C3 = 10
## l
n m : 60 18
gcd(60, 18) = 6
## m
a b c ...(MAX 256) : 12 11 9 5 12 6 7 9 11 11
ave : 9.30
std_dev : 5.81
```

### 演習 2

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

// a

void nabeatu(int max) {
    for (int i = 1; i <= max; i++) {
        if (i % 3 == 0) {
            printf("aho\n");
            continue;
        }
        int flag = 1,
            digit = (int)log10(i) + 1;
        while (flag && digit > 0) {
            if ( (i % (int)pow(10, digit) / (int)pow(10, digit-1)) == 3) {
                printf("aho\n");
                flag = 0;
            }
            digit--;
        }
        if (flag) printf("%d\n", i);
    }
}

// b

void fizzbuzz(int max) {
    for (int i = 1; i <= max; i++) {
        if (i % 15 == 0) {
            printf("fizzbuzz\n");
        } else if (i % 5 == 0) {
            printf("buzz\n");
        } else if (i % 3 == 0) {
            printf("fizz\n");
        } else {
            printf("%d\n", i);
        }
    }
}

// c エラトステネスの篩

void primes_byErat(int* primes_arr, int n) { // n == len(primes_arr)-1
    for (int i = 2; i <= sqrt(n); i++) {
        if (primes_arr[i] == 0) continue;
        for (int j = i * 2; j <= n; j += i) {
            if (primes_arr[j] != 0) primes_arr[j] = 0;
        }
    }

    int res = 0;
    for (int i = 2; i <= n; i++) {
        if (primes_arr[i] != 0) printf("%d\n", i);
        // if (primes_arr[i] != 0) res++;
    }
    // printf("primes num : %d\n", res);
}

// i 円周率の数値積分

double calculate_pi(double dx) {
    double res = 0;
    for (double x = 0; x <= 1; x += dx) {
        res += sqrt(1 - x*x) * dx;
    }
    return res * 4;
}

int main (void) {

    char str[MEM];

    printf("## a nabeatu\n");
    nabeatu(99);
    printf("\n## b fizzbuzz\n");
    fizzbuzz(99);

    int n = atoi(input(str, "\n## c prime numbers\nn : "));
    int* primes_arr = (int *)malloc((n+1) * sizeof(int));
    for (int i = 0; i <= n; i++) primes_arr[i] = 1;
    primes_byErat(primes_arr, n);
    free(primes_arr);

    n = atoi(input(str, "\n## d count down\nn : "));
    for (int i = n, j = 0; i > 0; i--, j++) {
        if (j % 10 == 0) printf("\n");
        printf("%2d ", i);
    }
    printf("\n");

    n = atoi(input(str, "\n## e chess board (1) \nn : "));
    for (int i = 0; i < n; i++) {
        if (i % 10 == 0) printf("\n");
        printf("%d ", i % 2);
    }
    printf("\n");

    n = atoi(input(str, "\n## f chess board (2) \nn : "));
    for (int i = 1; i <= n; i++) {
        if (i % 10 == 1) printf("\n");
        printf("%d ", i % 2);
    }
    printf("\n");

    n = atoi(input(str, "\n## g 3^n \nn : "));
    for (int i = 0; i < n; i++) {
        if (i % 10 == 0) printf("\n");
        printf("%d ", (int)pow(3, i));
    }
    printf("\n");

    printf("\n## h multiplication table \n\n* |");
    for (int i = 1; i <= 9; i++) printf(" %2d", i);
    printf("\n---");
    for (int i = 1; i <= 9; i++) printf("---");
    for (int i = 1; i <= 9; i++) {
        printf("\n%d |", i);
        for (int j = 1; j <= 9; j++) printf(" %2d", i*j);
    }
    printf("\n");

    // i C言語で数値積分

    printf("\n## i\npi = %lf\n", calculate_pi(1e-10));

    return 0;
}
```

#### a ナベアツ

`log10`関数を使用することで最大値に対応するようにした。
\
`3`を含むか否かは、`i % (int)pow(10, digit) / (int)pow(10, digit-1)`という式で各位の値が`3`であるかどうかを判断することにより求めた。

#### b fizzbuzz

きれいな場合分けで書ける。

#### c 素数判定

Rubyでも使用したエラトステネスの篩を使用して素数判定を行った。

#### d ~ g

特に難しい点はない。

#### h 九九

` %2d`のように書いて桁数を指定することで表示がきれいになるように工夫した。

#### i 数値積分による円周率導出

微小量`dx`を渡して繰り返し処理により積分した。Rubyで組んだものとほぼ同じである。

入出力例

```
## a nabeatu
1
2
aho
4
5
aho
7
8
aho
10

~~ 省略 ~~

aho
91
92
aho
94
95
aho
97
98
aho

## b fizzbuzz
1
2
fizz
4
buzz
fizz
7
8
fizz
buzz

~~ 省略 ~~

91
92
fizz
94
buzz
fizz
97
98
fizz

## c prime numbers
n : 40
2
3
5
7
11
13
17
19
23
29
31
37

## d count down
n : 40

40 39 38 37 36 35 34 33 32 31 
30 29 28 27 26 25 24 23 22 21 
20 19 18 17 16 15 14 13 12 11 
10  9  8  7  6  5  4  3  2  1 

## e chess board (1) 
n : 40

0 1 0 1 0 1 0 1 0 1 
0 1 0 1 0 1 0 1 0 1 
0 1 0 1 0 1 0 1 0 1 
0 1 0 1 0 1 0 1 0 1 

## f chess board (2) 
n : 40

1 0 1 0 1 0 1 0 1 0 
1 0 1 0 1 0 1 0 1 0 
1 0 1 0 1 0 1 0 1 0 
1 0 1 0 1 0 1 0 1 0 

## g 3^n 
n : 9

1 3 9 27 81 243 729 2187 6561 

## h multiplication table 

* |  1  2  3  4  5  6  7  8  9
------------------------------
1 |  1  2  3  4  5  6  7  8  9
2 |  2  4  6  8 10 12 14 16 18
3 |  3  6  9 12 15 18 21 24 27
4 |  4  8 12 16 20 24 28 32 36
5 |  5 10 15 20 25 30 35 40 45
6 |  6 12 18 24 30 36 42 48 54
7 |  7 14 21 28 35 42 49 56 63
8 |  8 16 24 32 40 48 56 64 72
9 |  9 18 27 36 45 54 63 72 81

## i
pi = 3.141592
```

## 演習 3 ~ 5について

以下演習 3 ~ 5は、

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

// 絶対値

double d_abs(double x) {
    if (x < 0) {
        return -x;
    } else {
        return x;
    }
}

double my_sqrt(double x, double dx) {
    /* 相違部分 */
}

int main (void) {

    char str[MEM];
    
    double x = atof(input(str, "x : "));
    printf("sqrt(%.2lf) = %.10lf", x, my_sqrt(x, 1e-9));

    return 0;
}
```

に関して共通である。`my_sqrt`関数の中身のみが異なる。

`my_sqrt`関数は以下のことが期待されている

```
my_sqrt :=
    引数
        x : double
        dx または acc : double
    返り値
        xの平方根 : double
```

第二引数の`dx`、`acc`は精度を決める。
\
実行に際して、`my_sqrt`関数の第二引数を変化させた結果をそれぞれ調べている。

### 演習 3

数え上げ法により`my_sqrt`関数を実装した。

```c
double my_sqrt(double x, double dx) {
    if (x == 0) return 0;
    if (x < 0) x *= -1;

    double res = 0;
    for (; res*res - x < 0 ; res += dx);
    return res;
}
```

`res*res - x`が0以上になるまで`dx`を`res`に足すことで解を求めている。

実行結果

```
// 1e-5
x : 5
sqrt(5.00) = 2.2360700000

// 1e-6
x : 5
sqrt(5.00) = 2.2360680000

// 1e-7
x : 5
sqrt(5.00) = 2.2360679999

// 1e-8
x : 5
sqrt(5.00) = 2.2360679848

// 1e-9
x : 5
sqrt(5.00) = 2.2360679778
```

誤差は大体第二引数に指定した`1e-n`であることが確認できる。

### 演習 4

区間2分法により`my_sqrt`関数を実装した。

```c
double my_sqrt(double x, double acc) {
    if (x == 0) return 0;
    if (x < 0) x *= -1;

    double
        a = 0,
        b = x > 1 ? x : 1,
        c = x / 2.0;
    double dif = c*c - x;
    int counter = 0;

    while (d_abs(dif) > acc) {
        if (dif > 0) {
            b = c;
        } else {
            a = c;
        }
        c = (a + b) / 2.0;
        dif = c*c - x;
        counter++;
    }
    printf("counter : %d\n", counter);
    return c;
}
```

解が含まれている開区間`(a, b)`の端`a`、`b`の平均`c`が解に近づくように、適宜`a`、`b`と`c`を交換していく。

`dif = c*c - x`として、`dif > 0`のときは`b`と、`dif <= 0`のときは`a`と`c`を交換する。

実行結果

```
// 1e-1
x : 5
counter : 6
sqrt(5.00) = 2.2265625000

// 1e-2
x : 5
counter : 8
sqrt(5.00) = 2.2363281250

// 1e-3
x : 5
counter : 13
sqrt(5.00) = 2.2360229492

// 1e-4
x : 5
counter : 16
sqrt(5.00) = 2.2360610962

// 1e-5
x : 5
counter : 19
sqrt(5.00) = 2.2360658646

// 1e-6
x : 5
counter : 23
sqrt(5.00) = 2.2360679507

// 1e-7
x : 5
counter : 26
sqrt(5.00) = 2.2360679880

// 1e-8
x : 5
counter : 28
sqrt(5.00) = 2.2360679787

// 1e-9
x : 5
counter : 31
sqrt(5.00) = 2.2360679775
```

精度が大きくなるにつれ比較回数も大きくなっている。
\
また、精度で指定した桁まで正確であることが確認できる。

### 演習 5

ニュートン法により`my_sqrt`関数を実装した。

```c
double my_sqrt(double x, double acc) {
    if (x == 0) return 0;
    if (x < 0) x *= -1;

    double
        res = x,
        pre_res = 0;
    int counter = 0;

    printf("\n");

    while (d_abs(res - pre_res) > acc) { // とりあえず絶対誤差で
        pre_res = res;
        // 第1回レポートのときには気づけなかった、テキストにあった変形を行った。
        res = pre_res / 2.0 + x / (2.0 * pre_res);
        counter++;

        printf("%.12lf\n", res);
    }

    printf("\ncounter : %d\n", counter);

    return res;
}
```

Rubyのときにも解説したので簡単にするが、微分定義をもとにした漸化式により値を更新していき、解を求めていく。

実行結果

```
// 1e-9
x : 5

3.000000000000
2.333333333333
2.238095238095
2.236068895643
2.236067977500
2.236067977500

counter : 6
sqrt(5.00) = 2.236067977500
```

精度`1e-9`でも高々6回で求めることができている。
\
また、4回を過ぎたあたりで急に正確になっている様子も確認できた。

### 演習 6

実行すると自分自身を出力するプログラム(通称クワイン quine)をC言語で行った。

```c
#include <stdio.h>

int main(void) {char s[256] = "#include <stdio.h>%c%cint main(void) {char s[256] = %c%s%c; printf(s, (char)10, (char)10, (char)34, s, (char)34); return 0;}"; printf(s, (char)10, (char)10, (char)34, s, (char)34); return 0;}
```

bashにて次の操作を行った。

```bash
$ gcc prac6.c -o prac6
$ ./prac6 > prac6_res.c
```

この結果を比較するために次のPythonプログラムを使用した。

```python
import sys

with open("prac6.c", "r") as f:
    original = f.read()

with open("prac6_res.c", "r") as f:
    res = f.read()

print(original == res)
```

結果は`True`となり、無事自身を出力できていることが確認できた。

`printf`関数と整数型→文字型へのキャストがこのプログラムのミソである。
\
改行やダブルクォートの整数値に関しては、次のコードで確認が可能であり、このプログラムの実行結果をもとにクワインを作成した。

```c
#include <stdio.h>

int main(void) {
    char t = '\"';
    printf("%d\n", (int)t );

    char u = '\n';
    printf("%d\n", (int)u );

    return 0;
}
```

## [考察]

C言語では、静的型付け言語であるという性質上、Ruby以上に型を意識する必要があることを演習を通して確認できた。

また、irbのようなインタラクティブモードがないという性質上、入出力に関しても自分で記述しなければならないものが多いという点がRubyとの大きな違いであった。

しかし記述が煩雑になってはいるものの、Rubyとの記述にそこまで大きな差がないことも実感した。実際、Rubyコードをほぼそのまま書き換えるだけで実装している関数もある。

## [アンケート]

- Q1. C言語でプログラムが書けるようになりましたか。

クワインが書ける程度には書けるようになりました。

- Q2. CとRubyはどのように違うと感じていますか。

考察にも書きましたがやはり動的型付けと静的型付けでは全く違うように感じます。またRubyに存在する便利な機能(例えばブロックなど)が使えないのはやはり不便に感じました。。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

C言語に入ってからどうにも進度が遅くなってしまっていますが、頑張っていきたいと思います。