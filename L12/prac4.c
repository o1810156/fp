#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>
#define MEM 256
#define RMAX 1024

// 入力用関数

char* input(char* str, char* desc) {
	// char str[MEM];
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

int roomprice[RMAX] = { 0, };
int roomsel[RMAX] = { 0, };
int room1(int i) {
	return (i < 0) ? 0 : roomprice[i];
}

void initialize(void) {

	for (int i = 1; i < RMAX; ++i) {
		int min = room1(i-1) + 5000, sel = 1;
		if(min > room1(i-3) + 12000) { min = room1(i-3) + 12000; sel = 3; }
		if(min > room1(i-7) + 20000) { min = room1(i-7) + 20000; sel = 7; }
		if(min > room1(i-13) + 30000) { min = room1(i-13) + 30000; sel = 13; }
		if(min > room1(i-17) + 40000) { min = room1(i-17) + 40000; sel = 17; }
		roomprice[i] = min; roomsel[i] = sel;
	}
}

int main(void) {
	int n;
	initialize();
	while(true) {
		printf("input number (0 for end)> "); scanf("%d", &n);
		if(n == 0) { return 0; }
		if(n<0 || n>=RMAX-1) { printf("%d: invalid\n", n); continue; }
		printf("room price for %d => %d;", n, roomprice[n]);
		while(n > 0) { printf(" %d", roomsel[n]); n -= roomsel[n]; }
		printf("\n");
	}
}
