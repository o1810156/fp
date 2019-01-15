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

// swap

void swap(int* a, int i, int j) {
	int tmp = a[i];
	a[i] = a[j];
	a[j] = tmp;
}

// quick_sort

void quick_sort(int* a, int i, int j) {
	if (j <= i) return;

	int t = rand() * ((j - i) / RAND_MAX) + i;
	t = i <= t && t <= j ? t : i;
	swap(a, t, j);
	int pivot = a[j],
		s = i;
	for (int k = i; k < j; k++) {
		if (a[k] <= pivot) swap(a, s++, k);
	}
	swap(a, j, s);
	quick_sort(a, i, s-1);
	quick_sort(a, s+1, j);
}

int main(int argc, char const *argv[]) {

	char str[MEM];
    char *args,
        *arr_str;
	srand(10);

    int arr[MEM];
    int arr_num = 0;

    if (argc > 1) {
        for (int i = 1; i < argc; i++) arr[i-1] = atoi(argv[i]);
        arr_num = argc-1;
    } else {
	    args = input(str, "array?\na b c ...(MAX 256) : ");
        arr_str = strtok(args, " ");
        for (; arr_str != NULL && arr_num < MEM; arr_num++) {
            arr[arr_num] = atoi(arr_str);
            arr_str = strtok(NULL, " ");
        }
    }

    quick_sort(arr, 0, arr_num-1);
    for (int i = 0; i < arr_num; i++) printf(" %d", arr[i]);
    printf("\n");
}

/*
$ ./prac1h
array?
a b c ...(MAX 256) : 4 8 9 5 2 5 6
 2 4 5 5 6 8 9

$ ./prac1h 7 2 4 5 8 3 4 8 5 3 9
 2 3 3 4 4 5 5 7 8 8 9
*/