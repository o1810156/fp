#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "input.h"

struct color { unsigned char r, g, b; };

void show_color(struct color c) {
    printf("%02x%02x%02x\n", c.r, c.g, c.b);
}

struct color read_css_color(char *disc) {
    struct color res;
    char *color_code;
    while (1) {
        color_code = input("CSS color code\n%s: #", disc);
        int len = strlen(color_code);
        if (len == 3) {
            sprintf(color_code, "%c%c%c%c%c%c",
                color_code[0], color_code[0],
                color_code[1], color_code[1],
                color_code[2], color_code[2]);
        }
        if (len == 3 || len == 6) {
            char r[] = {color_code[0], color_code[1], '\0'};
            char g[] = {color_code[2], color_code[3], '\0'};
            char b[] = {color_code[4], color_code[5], '\0'};
            res.r = (unsigned char)strtol(r, NULL, 16);
            res.g = (unsigned char)strtol(g, NULL, 16);
            res.b = (unsigned char)strtol(b, NULL, 16);
            break;
        }
        printf("Wrong code, please re-input.\n");
    }

    return res;
}

// a
void make_brighter(struct color *c) {
    c->r = (c->r+255)/2;
    c->g = (c->g+255)/2;
    c->b = (c->b+255)/2;
}

void make_darker(struct color *c) {
    c->r /= 2;
    c->g /= 2;
    c->b /= 2;
}

// b
void make_reverse(struct color *c) {
    c->r = 255 - c->r;
    c->g = 255 - c->g;
    c->b = 255 - c->b;
}

// c
// struct color rot1color(struct color c) {
void make_GBR(struct color *c) {
    *c = (struct color){ c->g, c->b, c->r };
}

// struct color rot2color(struct color c) {
void make_BRG(struct color *c) {
    *c = (struct color){ c->b, c->r, c->g };
}

// d
// void add_color(struct color *c, int dr, int dg, int db) {
//     c->r = c->r + dr < 256 ? c->r + dr : 255;
//     c->g = c->g + dg < 256 ? c->g + dg : 255;
//     c->b = c->b + db < 256 ? c->b + db : 255;
// }

void add_color(struct color *c, int dr, int dg, int db) {
    c->r += dr;
    c->g += dg;
    c->b += db;
}

// e
// void bit_differ(struct color *c) {
//     int dr = (int)(rand() % 21 - 10);
//     c->r = c->r + dr ? c->r + dr : 255;
//     int dg = (int)(rand() % 21 - 10);
//     c->g = c->g + dg ? c->g + dg : 255;    
//     int db = (int)(rand() % 21 - 10);
//     c->b = c->b + db ? c->b + db : 255;
// }

void bit_differ(struct color *c) {
    c->r += (int)(rand() % 21 - 10);
    c->g += (int)(rand() % 21 - 10);
    c->b += (int)(rand() % 21 - 10);
}

// f
// グレースケール
// https://qiita.com/yoya/items/96c36b069e74398796f3
// BT.601 係数を更に粗くする

void make_gray_scale(struct color *c) {
    unsigned char V = 0.3*c->r + 0.6*c->g + 0.1*c->b;
    c->r = V;
    c->g = V;
    c->b = V;
}

int main(void) {
    struct color tmp = read_css_color("");
    show_color(tmp);

    // a
    printf("a brighten : #");
    make_brighter(&tmp);
    show_color(tmp);

    // b
    printf("b reverse : #");
    make_reverse(&tmp);
    show_color(tmp);

    // c
    printf("c\nGBR : #");
    make_GBR(&tmp);
    show_color(tmp);
    printf("BRG : #");
    make_BRG(&tmp);
    show_color(tmp);

    // d
    printf("d add : #");
    add_color(&tmp, 0, -10, 50);
    show_color(tmp);

    // e
    srand(time(NULL));
    printf("e bit_differ : #");
    bit_differ(&tmp);
    show_color(tmp);

    // f
    printf("f gray scale : #");
    make_gray_scale(&tmp);
    show_color(tmp);

    return 0;
}
