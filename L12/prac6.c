#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	// char str[MEM];
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

int
    maxLen[MEM] = { 1, }, // 最大長を記憶しておく配列
    maxLen_pre_indexs[MEM] = { -1, }, // トレースバック
    arr_len_global = 0;

// int maxLen_getter(int i, int arr_len) {
// 最大長のゲッター
int maxLen_getter(int i) {
    // return i >= 0 ? maxLen[i] : 0;
    if (i < 0) {
        return 0;
    } else if (arr_len_global <= i) {
        return maxLen[arr_len_global-1];
    } else {
        return maxLen[i];
    }
}

void initialize(int *arr, int arr_len) {
    for (int i = 1; i < arr_len; i++) {
        int
            // max = arr[i] > arr[0] ? maxLen_getter(0) : 0,
            max = 0,
            pre_index = -1,
            next = 0; // 一時変数
        
        arr_len_global = arr_len;

        for (int j = 0; j < i; j++) {
            next = arr[i] > arr[j] ? maxLen_getter(j) : 0;
            // printf("%d %d\n", i, next);
            if (next > max) {
                max = next;
                pre_index = j;
            }
        }
        maxLen[i] = max + 1;
        maxLen_pre_indexs[i] = pre_index;
    }
}

int main(int argc, char const *argv[]) {
    int arr[MEM],
        arr_len = 0;

    // 入力
    if (argc > 1) {
        for (arr_len = 0; arr_len < argc-1 && arr_len < MEM; arr_len++) {
            arr[arr_len] = atoi(argv[arr_len+1]);
        }
    } else {
        char
            str[MEM],
            *tmp;
        
        tmp = strtok(input(str, "array ? : "), " ,");
        for (arr_len = 0; arr_len < MEM && tmp; arr_len++) {
            arr[arr_len] = atoi(tmp);
            tmp = strtok(NULL, " ,");
        }
    }

    // for (int i = 0; i < arr_len; i++) printf("%d ", arr[i]);
    // printf("\n");

    // 初期化
    initialize(arr, arr_len);

    // 最大のものを求める
    int
        max = 0,
        last_index = 0;
    for (int i = 0; i < arr_len; i++) {
        if (maxLen_getter(i) > max) {
            max = maxLen_getter(i);
            last_index = i;
        }
    }

    // 出力
    // 長さ
    printf("len = %d\nselect : ", max);

    // 選択した数字
    int
        tmp_arr[MEM],
        i = 0;

    while (last_index >= 0) {
        tmp_arr[i++] = arr[last_index];
        last_index = maxLen_pre_indexs[last_index];
    }

    for (int j = i-1; j >= 0; j--) printf("%d ", tmp_arr[j]);
    printf("\n");

    return 0;
}