#include <stdio.h>
#include <stdlib.h>
#define MEM 110

/*
AIZU ONLINE JUDGE ナップザック問題

http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_1_B&lang=jp

を動的計画法で解く

0-1 ナップザック問題
価値が vi 重さが wi であるような N 個の品物と、容量が W のナップザックがあります。次の条件を満たすように、品物を選んでナップザックに入れます：

選んだ品物の価値の合計をできるだけ高くする。
選んだ品物の重さの総和は W を超えない。
価値の合計の最大値を求めてください。

入力
１行目に２つの整数　N、W　が空白区切りで１行に与えられます。 続く N 行で i 番目の品物の価値 vi と重さ wi が空白区切りで与えられます。

出力
価値の合計の最大値を１行に出力してください。
*/

/* 
参考 : https://qiita.com/drken/items/a5e6fe22863b7992efdb
*/

int max2(int a, int b) {
    return a > b ? a : b;
}

int main(void) {

    // 入力

    int N, W;
    scanf("%d %d", &N, &W);

    int
        v_arr[MEM],
        w_arr[MEM];

    for (int i = 0; i < N; i++) scanf("%d %d", &v_arr[i], &w_arr[i]);

    // 計算

    int* max_values[MEM];
    
    for (int i = 0; i < MEM; i++) {
        max_values[i] = (int *)calloc( W+1, sizeof(int) );
        // max_values[i+1][w] := i番目までの品物から重さがwを超えないように選んだ時の価値の総和の最大値
    }

    // 初期化: 0番目のときの-1番目に関する価値 -> 全て0
    for (int w = 0; w <= W; w++) max_values[0][w] = 0; 

    for (int i = 0; i < N; i++) {
        for (int w = 0; w <= W; w++) {
            if (w >= w_arr[i]) {
                max_values[i+1][w] = max2( max_values[i][w - w_arr[i]] + v_arr[i], max_values[i][w] );
                // この商品を取った時の価値と取らずにwまで取った時の最大値を比べる。
            } else {
                max_values[i+1][w] = max_values[i][w];
                // この商品はもう取れないので取らなかったときの値が最大
            }
        }
    }

    // int max = 0;
    // for (int i = 0; i < N; i++) {
    // for (int i = 0; i <= N; i++) {
    //     if (max_values[i][W] > max) max = max_values[i][W];
    // }

    // 出力

    // printf("%d\n", max);
    printf("%d\n", max_values[N][W]);

    for (int i = 0; i < MEM; i++) {
        free(max_values[i]);
    }

    return 0;
}