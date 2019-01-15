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
