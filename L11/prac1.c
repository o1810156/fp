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

// a cone関数

double cone(double r, double h) {
	return (M_PI * r * r) * h / 3.0;
}

// d max2関数

int max2(int n, int m) {
	return n > m ? n : m;
}

// e min2関数

int min2(int n, int m) {
	return n < m ? n : m;
}

// f max_in_arr関数

int max_in_arr(int* arr, int numbers_num) {
	int max = arr[0];
	for (int i = 1; i < numbers_num; i++) {
		if (max < arr[i]) max = arr[i];
	}
	return max;
}

// g min_in_arr関数

int min_in_arr(int* arr, int numbers_num) {
	int min = arr[0];
	for (int i = 1; i < numbers_num; i++) {
		if (min > arr[i]) min = arr[i];
	}
	return min;
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

// h mean_of_arr関数

double mean_of_arr(int* arr, int numbers_num) {
	int b[MEM];
	for (int i = 0; i < numbers_num; i++) b[i] = arr[i];
	quick_sort(b, 0, numbers_num-1);

	if (numbers_num % 2 == 1) {
		return (float)b[numbers_num / 2];
	} else if (numbers_num > 0) {
		int m = numbers_num / 2;
		return (float)(b[m-1] + b[m]) / 2.0;
	} else {
		return 0;
	}
}

// 今回は再帰で定義

// i factorial関数

int factorial(int n) {
	return n > 0 ? n * factorial(n - 1) : 1;
}

// k combination関数

int combination(int n, int r) {
	if (r == 0 || r == n) {
		return 1;
	} else {
		return combination(n - 1, r) + combination(n - 1, r - 1);
	}
}

// l gcd関数

int gcd(int n, int m) {
	if (n == m) {
		return n;
	} else if (n > m) {
		return m != 0 ? gcd(n % m, m) : n;
	} else {
		return n != 0 ? gcd(m % n, n) : m;
	}
}

// m ave関数

double ave(int* arr, int num) {
	int sum = 0;
	for (int i = 0; i < num; i++) sum += arr[i];
	return sum / (double)num;
}

// m std_dev関数

double std_dev(int* arr, int num) {
	double av = ave(arr, num),
	       sum = 0;
	for (int i = 0; i < num; i++) {
		sum += pow(arr[i] - av, 2);
	}
	return sum / (double)num;
}

int main(void) {

	// 前処理
	char str[MEM];
	srand(10);

	// a
	printf("# prac 1\n## a\n");
	double r = atof(input(str, "r : "));
	double h = atof(input(str, "h : "));
	printf("cone V = %.3f\n", cone(r, h));

	// b
	double x = atof(input(str, "## b\nx : "));
	printf("sqrt(%.3f) = %.3f\n", x, sqrt(x));

	// c
	x = atof(input(str, "## c\nx : "));
	int n = atoi(input(str, "n : "));
	printf("%.3f^%d = %.3f\n", x, n, pow(x, n));

	// d
	char *n_m = input(str, "## d\nn m : ");
	n = atoi(strtok(n_m, " "));
	int m = atoi(strtok(NULL, " "));
	printf("lagger : %d\n", max2(n, m));

	// e
	n_m = input(str, "## e\nn m : ");
	n = atoi(strtok(n_m, " "));
	m = atoi(strtok(NULL, " "));
	printf("smaller : %d\n", min2(n, m));

	// f
	char *args = input(str, "## f\na b c ...(MAX 256) : ");
	int numbers[MEM];
	int numbers_num = 0;
	char *number_str = strtok(args, " ");
	for (; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}

	printf("largest : %d\n", max_in_arr(numbers, numbers_num));

	// g
	args = input(str, "## g\na b c ...(MAX 256) : ");
	numbers_num = 0;
	number_str = strtok(args, " ");
	for (; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}

	printf("smallest : %d\n", min_in_arr(numbers, numbers_num));

	// quick_sort test
	/*
	int a[5] = {4, 2, 6, 7, 3};
	quick_sort(a, 0, 4);
	for (int i = 0; i < 5; i++) printf("%d ", a[i]);
	printf("\n");
	*/

	// h 3つバージョン
	args = input(str, "## h(3)\na b c : ");
	number_str = strtok(args, " ");
	for(int i = 0; i < 3; i++) {
		numbers[i] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}
	printf("mean : %d\n", (int)mean_of_arr(numbers, 3));

	// h 複数バージョン
	args = input(str, "## h(n)\na b c ...(MAX 256) : ");
	numbers_num = 0;
	number_str = strtok(args, " ");
	for(; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}
	printf("mean : %.1f\n", mean_of_arr(numbers, numbers_num));

	// i
	n = atoi(input(str, "## i\nn : "));
	printf("%d! = %d\n", n, factorial(n));

	// j
	n = atoi(input(str, "## j\nn : "));
	printf("2^%d = %d\n", n, (int)pow(2, n));

	// k
	n = atoi(input(str, "## k\nn : "));
	int r2 = atoi(input(str, "r : "));
	printf("%dC%d = %d\n", n, r2, combination(n, r2));

	// gcd test
	// printf("gcd(%d, %d) = %d\n", 60, 18, gcd(60, 18));

	// l
	n_m = input(str, "## l\nn m : ");
	n = atoi(strtok(n_m, " "));
	m = atoi(strtok(NULL, " "));
	printf("gcd(%d, %d) = %d\n", n, m, gcd(n, m));

	// m 平均値と標準偏差を打ち出す
	args = input(str, "## m\na b c ...(MAX 256) : ");
	numbers_num = 0;
	number_str = strtok(args, " ");
	for(; number_str != NULL && numbers_num < MEM; numbers_num++) {
		numbers[numbers_num] = atoi(number_str);
		number_str = strtok(NULL, " ");
	}
	printf("ave : %.2f\nstd_dev : %.2f\n", ave(numbers, numbers_num), std_dev(numbers, numbers_num));

	return 0;
}
