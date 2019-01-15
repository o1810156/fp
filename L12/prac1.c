#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MEM 256

// 例題の動作確認

void piarray(int n, int a[]) { // p i array ということらしい...
    int i;
    for (i = 0; i < n; ++i) {
        printf("%2d", a[i]);
        if (i % 10 == 9 || i == n-1) printf("\n");
    }
}

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

// a

void pi_array_rev(int n, int* a) {
    for (int i = n-1; i >= 0; i--) {
        printf("%2d", a[i]);
        if ((n - i - 1) % 10 == 9) printf("\n");
    }
    printf("\n");
}

// b
// 普通indexOfという関数なので名前をそうした
// Rubyなら複数入っているときはタプルを返したりなどできるが、C言語では難しいので断念した

int indexOf(int n, int* a, int x) {
    for (int i = 0; i < n; i++) {
        if (a[i] == x) return i;
    }
    return -1;
}

// c

int max_int_array(int n, int* a) {
    int m = a[0];
    for (int i = 1; i < n; i++) {
        if (m < a[i]) m = a[i];
    }

    return m;
}

// d

int min_int_array(int n, int* a) {
    int m = a[0];
    for (int i = 1; i < n; i++) {
        if (m > a[i]) m = a[i];
    }

    return m;
}

// e

int sum_int_array(int n, int* a) {
    int sum = 0;
    for (int i = 0; i < n; i++) sum += a[i];
    return sum;
}

// f

double avg_int_array(int n, int* a) {
    return sum_int_array(n, a) / (double)n;
}

int main(void) {

    char str[MEM];

    // ex
    int a[24] = {1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8};

    // 全体の表示

    printf("# ex\n## all\n\n");
    piarray(24, a);

    // 一部の表示

    printf("\n## parts\n### 1\n\n");
    piarray(5, a+2);
    
    printf("\n### 2\n\n");    
    piarray(8, a+8);

    // a

    printf("\n# a\n\n");
    pi_array_rev(24, a);

    // b

    printf("\n# b\n\n");
    printf("5 is at %2d in a.\n", indexOf(24, a, 5));
    printf("5 is at %2d in %s.\n", indexOf(3, a+2, 5), int_array2str(str, 3, a+2));
    printf("9 is at %2d in a.\n", indexOf(24, a, 9));
    printf("5 is at %2d in %s.\n", indexOf(3, a+5, 5), int_array2str(str, 3, a+5));

    // c

    printf("\n# c\n\n%d is max of a.\n", max_int_array(24, a));
    printf("%d is max of %s.\n", max_int_array(3, a+2), int_array2str(str, 3, a+2));

    // d

    printf("\n# d\n\n%d is min of a.\n", min_int_array(24, a));
    printf("%d is min of %s.\n", min_int_array(3, a+2), int_array2str(str, 3, a+2));

    // e

    printf("\n# e\n\nsum of a is %d.\n", sum_int_array(24, a));
    printf("sum of %s is %d.\n", int_array2str(str, 3, a+2), sum_int_array(3, a+2));

    // f

    printf("\n# f\n\naverage of a is %lf.\n", avg_int_array(24, a));
    printf("average of %s is %lf.\n", int_array2str(str, 3, a+2), avg_int_array(3, a+2));

    return 0;
}
