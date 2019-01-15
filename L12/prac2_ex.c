#include <stdio.h>

void piarray(int n, int a[]) {
    int i;
    for(i = 0; i < n; ++i) {
        printf(" %2d", a[i]);
        if(i % 10 == 9 || i == n-1) { printf("\n"); }
    }
}

void riarray(int n, int a[]) {
    int i;
    for(i = 0; i < n; ++i) {
        printf("%d> ", i+1); scanf("%d", a+i); // &a[i] でも OK
    }
}

int main(void) {
    int n, a[100];
    printf("n> "); scanf("%d", &n);
    riarray(n, a); piarray(n, a);
    return 0;
}
