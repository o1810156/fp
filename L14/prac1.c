#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "input.h"

struct color { unsigned char r, g, b; };

void show_color(struct color c) {
    printf("%02x%02x%02x\n", c.r, c.g, c.b);
}

struct color mix_color(struct color c, struct color d) {
    struct color ret = { (c.r+d.r)/2, (c.g+d.g)/2, (c.b+d.b)/2 };
    return ret;
}

struct color read_color(void) {
    struct color ret;
    ret.r = atoi(input("r(0-255)> "));
    ret.g = atoi(input("g(0-255)> "));
    ret.b = atoi(input("b(0-255)> "));
    return ret;
}

struct color read_css_color(char *disc) {
    struct color res;
    char *color_code;
    while (1) {
        color_code = input("CSS color code\n%s : #", disc);
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
struct color brightered(struct color c) {
    return (struct color){ (c.r+255)/2, (c.g+255)/2, (c.b+255)/2 };
}

// b
struct color darkered(struct color c) {
    return (struct color){ c.r/2, c.g/2, c.b/2 };
}

// c
struct color reversed(struct color c) {
    return (struct color){ 255 - c.r, 255 - c.g, 255 - c.b };
}

// d
// struct color rot1color(struct color c) {
struct color GBR_color(struct color c) {
    return (struct color){ c.g, c.b, c.r };
}

// struct color rot2color(struct color c) {
struct color BRG_color(struct color c) {
    return (struct color){ c.b, c.r, c.g };
}

// e
struct color linear_mix(struct color c, struct color d, double ratio) {
    double t = 1 - ratio;
    return (struct color){ (int)(c.r*ratio + d.r*t), (int)(c.g*ratio + d.g*t), c.b*ratio + d.b*t };
}

// f
struct color random_color(void) {
    return (struct color){ (int)(rand() % 256), (int)(rand() % 256), (int)(rand() % 256) };
}

// g
// 思いつかないのであとで
// マンセル色相からの変換とか面白そう

// ...むりぽ

// 補色を求める計算
// http://appakumaturi.hatenablog.com/entry/20120121/1327143125

struct color comp_color(struct color c) {
    int
        max = c.r,
        min = c.r,
        sum = 0;

    if (c.g > max) max = c.g;
    if (c.b > max) max = c.b;

    if (c.g < min) min = c.g;
    if (c.b < min) min = c.b;

    sum = max + min;

    return (struct color){sum - c.r, sum - c.g, sum - c.b};
}

int main(void) {
    struct color white = { 255, 255, 255 };
    struct color c1 = { 10, 100, 120 };
    show_color(c1);
    show_color(mix_color(white, c1));

    struct color tmp = read_css_color("tmp");
    show_color(tmp);

    // a
    printf("a brightered : #");
    show_color(brightered(tmp));

    // b
    printf("b darkered : #");
    show_color(darkered(tmp));

    // c
    printf("c reverse : #");
    show_color(reversed(tmp));

    // d
    printf("d\nGBR : #");
    show_color(GBR_color(tmp));
    printf("BRG : #");
    show_color(BRG_color(tmp));

    //e
    printf("e\n");
    struct color c_a = read_css_color("c_a");
    struct color c_b = read_css_color("c_b");
    double ratio = atof(input("ratio : "));
    printf("linear mix : #");
    show_color(linear_mix(c_a, c_b, ratio));

    // f
    srand(time(NULL));
    struct color rdm = random_color();
    printf("f random : #");
    show_color(rdm);

    // g
    printf("g complementary : #");
    show_color(comp_color(tmp));

    return 0;
}
