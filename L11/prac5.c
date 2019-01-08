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

int main (void) {

    char str[MEM];
    
    double x = atof(input(str, "x : "));
    printf("sqrt(%.2lf) = %.12lf", x, my_sqrt(x, 1e-9));

    return 0;
}

/*
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
*/