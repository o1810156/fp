#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>
#include "prac6.h"

int main(int argc, char *argv[]) {
    srand(10);
    if(argc != 2) { fprintf(stderr, "need count.\n"); return 1; }
    int i, count = atoi(argv[1]);
    struct timespec t1, t2;
    clock_gettime(CLOCK_REALTIME, &t1);
    for(i = 0; i < count; ++i) {
        char buf[100];
        // sprintf(buf, "s%d", (int)(drand48()*10000000));
        sprintf(buf, "s%d", (int)(rand()/(float)RAND_MAX * 10000000));
        tbl_put(buf, i+1);
        int k = tbl_get(buf);
    }
    clock_gettime(CLOCK_REALTIME, &t2);
    int msec = 1000*(t2.tv_sec-t1.tv_sec) +
        (t2.tv_nsec-t1.tv_nsec)/1000000;
    printf("%d\n", msec);

    return 0;
}
