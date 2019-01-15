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

void perm(int n, char *a, int a_len, char *str) {

    if (n == 0) {
        printf("%s\n", str);
        return;
    }

    for (int i = 0; i < a_len; i++) {
        if (a[i] == '\0') continue;
        char tmp[] = {a[i], '\0'};
        strcat(str, tmp);
        a[i] = '\0';
        perm(n-1, a, a_len, str);
        // printf("%d\n", n-1);
        for (int j = 0; str[j] != '\0'; j++) {
            if (str[j+1] == '\0') str[j] = '\0';
        }
        a[i] = tmp[0];
    }
}

/*
void perm(int n, char *a, char *str) {
    if (n == 0) {
        printf("hoge\n");
        return;
    }
    for (int i = 0; i < n; i++) {
        perm(n-1, a, str);
    }
}
*/

int main(int argc, char const *argv[]) {
    char mem[MEM],
        a[] = "hoge";
    perm(3, a, 4, mem);
    return 0;
}
