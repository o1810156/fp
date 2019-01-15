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
