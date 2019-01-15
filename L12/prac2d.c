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

// 打ち出し

void pdarray(int n, double *a) {
    for (int i = 0; i < n; i++) {
        printf(" %.1lf", a[i]);
        if (i % 10 == 9 || i == n-1) printf("\n");
    }
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
