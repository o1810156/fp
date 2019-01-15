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
