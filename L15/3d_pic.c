#include <stdio.h>
#include <math.h>
#include "img.h"

#ifndef M_PI
#define M_PI 3.141592653589793
#endif

#ifndef M_SIZE
#define M_SIZE 256
#endif

#ifndef MEM
#define MEM 256
#endif

#ifndef BIG_NUM
#define BIG_NUM 10000
#endif

#ifndef LIGHT_INT
#define LIGHT_INT 5
#endif

struct vector3 {
    double x;
    double y;
    double z;
};

// 透視投影 参考 : http://satoh.cs.uec.ac.jp/ja/lecture/ComputerGraphics/3.pdf
// カメラを原点と考え、ウィンドウが距離dの位置にある。

static double
    x_reg = 0,
    y_reg = 0,
    z_reg = 0,
    camera_d = 0,
    tilde_z_min = 0,
    center_x = 0,
    center_y = 0,
    center_z = 0;

static struct vector3 light;

static double proj_mat[4][M_SIZE] = {
    {1, 0, 0, 0},
    {0, 1, 0, 0},
    {0, 0, 0, 0},
    {0, 0, 0, 0}
};

static double z_map[HEIGHT][WIDTH];

void z_map_init() {
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            z_map[i][j] = BIG_NUM;
        }
    }
}

void clear3d() {
    z_map_init();
    img_clear();
}

void camera_init(double d, double max, double min) {
    camera_d = d;
    x_reg = d / (WIDTH/2.0 * max);
    y_reg = d / (HEIGHT/2.0 * max);
    z_reg = 1 / max;
    tilde_z_min = min / max;

    proj_mat[2][2] = 1 / (1-tilde_z_min);
    proj_mat[2][3] = -tilde_z_min / (1 - tilde_z_min);
}

// void center_init(double x, double y, double z) {
void center_init(struct vector3 v) {
    center_x = v.x;
    center_y = v.y;
    center_z = v.z;
}

void light_init(struct vector3 v) {
    // 無限遠光源にする
    // ✖光の進行方向を指定
    // 〇光源の存在する方向を指定
    light = (struct vector3){-v.x, -v.y, v.z};
}

static void dot(double a[][M_SIZE], double b[][M_SIZE], double c[][M_SIZE],
        int top, int middle, int bottom) {
    for (int i = 0; i < top; i++) {
        for (int j = 0; j < bottom; j++) {
            c[i][j] = 0;
            for (int k = 0; k < middle; k++) {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

struct vector3 to_proj(struct vector3 v) {
    // x, y軸正規化
    v.x = (v.x-WIDTH/2.0) * x_reg;
    v.y = (v.y-HEIGHT/2.0) * y_reg;
    // 鏡像化 & z軸正規化
    v.z = -v.z * z_reg;

    double
        res[4][M_SIZE],
        a[4][M_SIZE] = {
            {v.x},
            {v.y},
            {v.z},
            {1}
        };
    dot(proj_mat, a, res, 4, 4, 1);

    return (struct vector3){-(res[0][0]/x_reg) / (res[2][0]/z_reg) * camera_d + WIDTH/2.0, -(res[1][0]/y_reg) / (res[2][0]/z_reg) * camera_d + HEIGHT/2.0, res[2][0]/z_reg};
}

void put_pixel3d(struct color c, int x, int y, double z) {
    // printf("x : %d y : %d\n", x, y);
    if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) return;
    if (z_map[y][x] > z) {
        img_putpixel(c, x, y);
        z_map[y][x] = z;
    }
}

void projection(struct vector3 v, struct color c) {
    double z = v.z;
    v = to_proj(v);

    // img_putpixel(c, (res[0][0]/x_reg) / (res[2][0]/z_reg) * camera_d + WIDTH/2.0, (res[1][0]/y_reg) / (res[2][0]/z_reg) * camera_d + HEIGHT/2.0);
    put_pixel3d(c, v.x, v.y, z);
}

static struct vector3 rote(struct vector3 v, double theta, double rote_mat[][M_SIZE]) {
    double
        b[4][M_SIZE] = {
            {v.x - center_x},
            {v.y - center_y},
            {v.z - center_z},
            {1}
        },
        res[4][M_SIZE];
    dot(rote_mat, b, res, 4, 4, 1);
    return (struct vector3){res[0][0]+center_x, res[1][0]+center_y, res[2][0]+center_z};
}

struct vector3 roteX(struct vector3 v, double theta) {
    double rote_mat[][M_SIZE] = {
        {1, 0, 0, 0},
        {0, cos(theta), -sin(theta), 0},
        {0, sin(theta), cos(theta), 0},
        {0, 0, 0, 1}
    };
    return rote(v, theta, rote_mat);
}

struct vector3 roteY(struct vector3 v, double theta) {
    double rote_mat[][M_SIZE] = {
        {cos(theta), 0, sin(theta), 0},
        {0, 1, 0, 0},
        {-sin(theta), 0, cos(theta), 0},
        {0, 0, 0, 1}
    };
    return rote(v, theta, rote_mat);
}

struct vector3 roteZ(struct vector3 v, double theta) {
    double rote_mat[][M_SIZE] = {
        {cos(theta), -sin(theta), 0, 0},
        {sin(theta), cos(theta), 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1}
    };
    return rote(v, theta, rote_mat);
}

/* 多角形描写 */

static double oprod(double a, double b, double c, double d) {
    return a*d - b*c;
}

static int isinside(double x, double y, int n, double ax[], double ay[]) {
    int i;
    for(i = 0; i < n; ++i) {
        if(oprod(ax[(i+1)%n]-ax[i], ay[(i+1)%n]-ay[i], x-ax[i], y-ay[i]) < 0) return 0;
    }
    return 1;
}

static double amax(int n, double a[]) {
    double m = a[0];
    int i;
    for(i = 0; i < n; ++i) { if(m < a[i]) { m = a[i]; } }
    return m;
}

static double amin(int n, double a[]) {
    double m = a[0];
    int i;
    for(i = 0; i < n; ++i) { if(m > a[i]) { m = a[i]; } }
    return m;
}

void fill_convex(struct color c, int n, double ax[], double ay[], double z) {
    int xmax = (int)(amax(n, ax)+1), xmin = (int)(amin(n, ax)-1);
    int ymax = (int)(amax(n, ay)+1), ymin = (int)(amin(n, ay)-1);
    int i, j;
    for(i = xmin; i <= xmax; ++i) {
        for(j = ymin; j <= ymax; ++j) {
            if(isinside(i, j, n, ax, ay)) put_pixel3d(c, i, j, z);
        }
    }
}

void fill_triangle3d(struct color c, struct vector3 v0,
        struct vector3 v1, struct vector3 v2) {
    double z = (v0.z + v1.z + v2.z) / 3.0;
    v0 = to_proj(v0);
    v1 = to_proj(v1);
    v2 = to_proj(v2);
    double
        x0 = v0.x,
        y0 = v0.y,
        x1 = v1.x,
        y1 = v1.y,
        x2 = v2.x,
        y2 = v2.y;

    double ax1[] = { x0, x1, x2, x0 }, ax2[] = { x0, x2, x1, x0 };
    double ay1[] = { y0, y1, y2, y0 }, ay2[] = { y0, y2, y1, y0 };
    fill_convex(c, 3, ax1, ay1, z);
    fill_convex(c, 3, ax2, ay2, z);
}

static void swap(struct vector3 *a, struct vector3 *b) {
    struct vector3 tmp = *a;
    *a = *b;
    *b = tmp;
}

static double reg_theta(double theta) {
    return theta >= 0 ? theta : 2 * M_PI - theta;
}

static double vec2theta(struct vector3 v, struct vector3 cent) {
    double theta = acos((v.x - cent.x) / sqrt(pow(v.x - cent.x, 2) + pow(v.y - cent.y, 2)));
    return reg_theta((v.y > cent.y ? 1 : -1) * theta + M_PI);
}

void fill_polygon(struct color c, int n, struct vector3 points[]) {
    double
        z = 0,
        gx = 0,
        gy = 0,
        ax[MEM], ay[MEM];
    struct vector3 sorted_points[MEM];
    for (int i = 0; i < n; i++) {
        z += points[i].z;
        sorted_points[i] = to_proj(points[i]);
        gx += sorted_points[i].x;
        gy += sorted_points[i].y;
    }
    z /= (float)n;
    gx /= (float)n;
    gy /= (float)n;
    struct vector3 g = {gx, gy, 0};

    // thetaでセレクトソート
    for (int i = 0; i < n; i++) {
        double min = vec2theta(sorted_points[i], g);
        int min_ind = i;
        for (int j = i; j < n; j++) {
            double theta = vec2theta(sorted_points[j], g);
            if (theta < min) {
                min_ind = j;
                min = theta;
            }
        }
        swap(sorted_points+i, sorted_points+min_ind);
    }

    for (int i = 0; i < n; i++) {
        ax[i] = sorted_points[i].x;
        ay[i] = sorted_points[i].y;
        // printf("%f %f\n", ax[i], ay[i]);
    }
    // printf("\n");

    fill_convex(c, n, ax, ay, z);
}

void fill_line3d(struct color c, struct vector3 v0,
        struct vector3 v1, double w) {
    double z = (v0.z + v1.z) / 2.0;
    v0 = to_proj(v0);
    v1 = to_proj(v1);
    double
        x0 = v0.x,
        y0 = v0.y,
        x1 = v1.x,
        y1 = v1.y;

    double dx = y1-y0, dy = x0-x1, n = 0.5*w / sqrt(dx*dx + dy*dy);
    dx *= n; dy *= n;
    double ax[] = { x0-dx, x0+dx, x1+dx, x1-dx, x0-dx };
    double ay[] = { y0-dy, y0+dy, y1+dy, y1-dy, y0-dy };
    fill_convex(c, 4, ax, ay, z);
}

/* 多角形描写ここまで */

/* 陰を付ける */

// 参考 : https://ja.wikipedia.org/wiki/%E3%82%B7%E3%82%A7%E3%83%BC%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0

struct color shaded(struct color c, struct vector3 normal) {
    double
        light_mag = sqrt(light.x*light.x+light.y*light.y+light.z*light.z),
        normal_mag = sqrt(normal.x*normal.x+normal.y*normal.y+normal.z*normal.z);
    double cosv = (light.x * normal.x + light.y * normal.y + light.z * normal.z)
        / ( (light_mag != 0 ? light_mag : 0.001) * (normal_mag != 0 ? normal_mag : 0.001) );
    // printf("cosv : %f\n", cosv);
    double intensity = pow(LIGHT_INT, cosv);

    struct color res;

    if (c.r * intensity >= 256) {
        res.r = 255;
        res.g = (c.g + c.r * 0.1) * intensity < 256 ? (c.g + c.r * 0.1) * intensity : 255;
        res.b = (c.b + c.r * 0.1) * intensity < 256 ? (c.b + c.r * 0.1) * intensity : 255;
    } else if (c.g * intensity >= 256) {
        res.r = (c.r + c.g * 0.1) * intensity < 256 ? (c.r + c.g * 0.1) * intensity : 255;
        res.g = 255;
        res.b = (c.b + c.g * 0.1) * intensity < 256 ? (c.b + c.g * 0.1) * intensity : 255;
    } else if (c.b * intensity >= 256) {
        res.r = (c.r + c.b * 0.1) * intensity < 256 ? (c.r + c.b * 0.1) * intensity : 255;
        res.g = (c.g + c.b * 0.1) * intensity < 256 ? (c.g + c.b * 0.1) * intensity : 255;
        res.b = 255;
    } else {
        res.r = c.r * intensity;
        res.g = c.g * intensity;
        res.b = c.b * intensity;
    }

    return res;
}

// カメラ方向に延びる法線ベクトルを求める
struct vector3 get_normal(struct vector3 a,
        struct vector3 b,
        struct vector3 c) {
    struct vector3
        ab = {b.x - a.x, b.y - a.y, b.z - a.z},
        ac = {c.x - a.x, c.y - a.y, c.z - a.z};
    
    struct vector3 res = {
        ab.y * ac.z - ab.z * ac.y,
        ab.z * ac.x - ab.x * ac.z,
        ab.x * ac.y - ab.y * ac.x
    };

    if (res.z > 0) {
        res.x *= -1;
        res.y *= -1;
        res.z *= -1;
    }

    return res;
}

/* 陰を付ける ここまで */

/* 球 */

/* メモ用に作った疑似関数のため実際は使用しない。
void fill_circle(struct color c, struct vector3 center, double r) {
    struct vector3 p = to_proj(center);
    for (int i = 0; i <= 2r; i++) {
        for (int j = 0; j <= 2r; j++) {
            if (i*i+j*j <= r*r) put_pixel3d(c, i, j, center.z);
        }
    }
}
*/

// 暗黙で陰付きとする。理由は単純。そうじゃないと球っぽくないから。

void draw_sphere(struct color c, struct vector3 center, double r, double d_theta) {
    struct vector3 pre_center = {center_x, center_y, center_z};

    center_init(center);
    struct vector3 p;
    for (double u = 0; u < 2*M_PI; u+=d_theta) {
        for (double v = 0; v < 2*M_PI; v+=d_theta) {
            for (double w = 0; w < 2*M_PI; w+=d_theta) {
                p = (struct vector3){
                    center.x + r,
                    center.y,
                    center.z
                };
                p = roteX(p, u);
                p = roteY(p, v);
                p = roteZ(p, w);

                if (p.z > center.z) continue;

                // fill_circle(shaded(c, (struct vector3){center.x - p.x, center.y - p.y, center.z - p.z}), p, d_theta * r);
                double s = d_theta * r;
                struct vector3 tmp = to_proj(p);
                for (int i = -s; i <= s; i++) {
                    for (int j = -s; j <= s; j++) {
                        double
                            tx = tmp.x + i,
                            ty = tmp.y + j;
                        // double
                        //     ux = tx - center.x,
                        //     uy = ty - center.y;
                        // if (i*i+j*j <= s*s && ux*ux + uy*uy < r*r) {
                        if (i*i+j*j <= s*s) {
                            put_pixel3d(shaded(c, (struct vector3){p.x - center.x, p.y - center.y, p.z - center.z}), tmp.x+i, tmp.y+j, center.z);
                            // put_pixel3d(shaded(c, (struct vector3){center.x - p.x, center.y - p.y, center.z - p.z}), tmp.x+i, tmp.y+j, center.z);
                        }
                    }
                }
            }
        }
    }
    center_init(pre_center);
}

/* 球 ここまで */