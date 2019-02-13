#ifndef _TBL_H_
#define _TBL_H_

extern bool tbl_put(char *k, int v);
extern int tbl_get(char *k);
extern bool tbl_rm(char *k);
extern void tbl_show(void);
extern void tbl_multi_inputs(void);

#endif
