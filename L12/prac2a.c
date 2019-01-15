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

int main(void) {
    int a[MEM];

    printf("%d\n", read_int_array_zero(MEM, a));

    return 0;
}
