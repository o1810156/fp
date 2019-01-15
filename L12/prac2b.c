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

int main(void) {
    int a[MEM];
    char str[MEM];
    int endval;

    endval = atoi(input(str, "endval> "));
    printf("%d\n", read_int_array_zero2(MEM, a, endval));

    return 0;
}
