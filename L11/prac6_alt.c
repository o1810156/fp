// 未完成

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
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

// 階乗関数

int factorial(int n) {
    int res = 1;
    for (int i = n; i >= 1; i--) res *= i;
    return res;
}

// ネイピア数 e

// 次のマクローリン展開を使用した

double calculate_e(double acc) {
    double
        res = 0,
        pre_res = 0;
    int i = 0;
    do {
        pre_res = res;
        res += 1.0 / (double)factorial(i++);
    } while (d_abs(res - pre_res) > acc);

    return res;
}

// 指数関数の実装

double exp_of_e(double x, double acc) {
// double exp_of_e(double x) {
    int
        t = round(x > 0 ? x : -x),
        i = 0;
    double
        x2 = x > 0 ? x : -x,
        res = 0.0,
        a = 0.0,
        b = 0.0,
        pre_res = 0.0,
        u = x2 - t,
        u_n = 1.0,
        u_n = 1.0,
        e = calculate_e(1e-5);
    printf("u = %lf\n", u);
    do {
        pre_res = res;
        for (int j = 0; j < i; j++) u_n *= u;
        a += ( 1.0 / (double)factorial(i++) ) * u_n;
        for (int j = 0; j < i; j++) u_n *= u;
        b += ( e / ((double)factorial(i++)) ) * 
    } while (d_abs(res - pre_res) > acc);

    // for (int i = 0; i < 6; i++) {
    //     for (int j = 0; j < i; j++) u_n *= u;
    //     res += ( 1.0 / (double)factorial(i) ) * u_n;
    //     printf("res = %lf\n", res);
    // }

    for (int j = 0; j < t; j++) res *= e;

    return res;
}

double exp_r(double x, double a) {

}

/*
double exp_r(double x, double a) {
    if (x == 1 || a == 0) return 1;

    double
        b = a > 0 ? a : -a,
        t,
        res = 1;

    int i;

    for (i = 0; i < b; i++) {
        res *= x;
    }

    if (x > 1) {
        t = x - 1;
        res *= 
    } else {

    }

} */

// log関数の実装

double log_e(double x) {
    if (x <= 0) return 0;


}

int main(void) {

    char str[MEM];
    double e = calculate_e(1e-5);

    // printf("e = %7lf\n", e); // => e = 2.718282
    // for (int i = 0; i < 10; i++) printf("%d! = %d\n", i, factorial(i));

    // printf("e^10.23 = %7lf\n", exp_of_e(10.23, 1e-5));
    printf("e^0.5 = %7lf\n", exp_of_e(0.1, 1e-5));

    return 0;
}