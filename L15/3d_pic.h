#ifndef _H_3D_PIC_
#define _H_3D_PIC_

struct vector3 {
    double x;
    double y;
    double z;
};

extern void camera_init(double d, double max, double min);
extern void clear3d();
// extern void center_init(double x, double y, double z);
extern void center_init(struct vector3 v);
extern void light_init(struct vector3 v);

extern void projection(struct vector3 v, struct color c);

extern struct vector3 roteX(struct vector3 v, double theta);
extern struct vector3 roteY(struct vector3 v, double theta);
extern struct vector3 roteZ(struct vector3 v, double theta);

extern void fill_convex(struct color c, int n, double ax[], double ay[], double z);
extern void fill_triangle3d(struct color c, struct vector3 v0, struct vector3 v1, struct vector3 v2);
extern void fill_polygon(struct color c, int n, struct vector3 points[]);
extern void fill_line3d(struct color c, struct vector3 v0, struct vector3 v1, double w);

extern struct color shaded(struct color c, struct vector3 normal);
extern struct vector3 get_normal(struct vector3 a, struct vector3 b, struct vector3 c);

extern void draw_sphere(struct color c, struct vector3 center, double r, double d_theta);

#endif