#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define MAX_MEM 65536
#define MEM 256

// 入力用関数

char* input(char* str, char* desc) {
	// char str[MEM];
	printf(desc);
	fgets(str, MEM, stdin);
	return str;
}

int coins_num[MAX_MEM] = { 0, };
int coins_select[MAX_MEM] = { 0, };

int coins_kind[] = {1, 5, 10, 25, 50, 100, 1000};
int coins_kind_len = 7;

int coin_getter(int c) {
    return c >= 0 ? coins_num[c] : -1;
}

void initialize(void) {
    for (int i = 1; i < MAX_MEM; i++) {
        int
            min = coin_getter(i - coins_kind[0]),
            select = coins_kind[0],
            next = 0;
        for (int j = 1; j < coins_kind_len; j++) {
            next = coin_getter(i - coins_kind[j]);
            if (min > next && next >= 0) {
                min = next;
                select = coins_kind[j];
            }
        }
        coins_num[i] = min + 1;
        coins_select[i] = select;
    }
}

int main(void) {
    char str[MEM];
    int
        change = 0,
        // c_num = 0,
        tmp = 0;
        // sum = 0;

    initialize();
    
    while (1) {
        // sum = 0;
        change = atoi(input(str, "change? (0 for end)\n: "));
        
        // 例外処理
        if (change == 0) {
            return 0;
        } else if (change < 0 || change >= MAX_MEM) {
            printf("invalid change. please 0 ~ %d\n", MAX_MEM);
            continue;
        }

        printf("coins : ");

        tmp = change;
        while (tmp > 0) {
            // sum += coins_select[tmp];
            printf(" %2d", coins_select[tmp]);
            tmp -= coins_select[tmp];
        }
        printf("\n");

        printf("coins_num : %d\n", coins_num[change]);
        // printf("sum : %d\n", sum);
    }

    return 0;
}