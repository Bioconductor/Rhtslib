#ifndef SAMTOOLS_1_7_COMPAT_H
#define SAMTOOLS_1_7_COMPAT_H

#include <htslib/bgzf.h>
#include <htslib/sam.h>
#include <bam_plbuf.h>

/* Defined in samtools-1.7/bam.h and gone in samtools-1.18 */

typedef BGZF *bamFile;
#define bam_open(fn, mode) bgzf_open(fn, mode)
#define bam_close(fp) bgzf_close(fp)
#define bam_tell(fp) bgzf_tell(fp)
#define bam_seek(fp, pos, dir) bgzf_seek(fp, pos, dir)

typedef bam_hdr_t bam_header_t;

#define data_len l_data

typedef hts_itr_t *bam_iter_t;

#define bam1_strand(b) (bam_is_rev((b)))
#define bam1_cigar(b) (bam_get_cigar((b)))
#define bam1_qname(b) (bam_get_qname((b)))
#define bam1_seq(b) (bam_get_seq((b)))
#define bam1_qual(b) (bam_get_qual((b)))
#define bam1_seqi(s, i) (bam_seqi((s), (i)))

#define bam_verbose hts_verbose

#define bam_nt16_table seq_nt16_table
#define bam_nt16_rev_table seq_nt16_str

static inline int32_t bam_get_tid(const bam_header_t *header, const char *seq_name) { return bam_name2id((bam_header_t *)header, seq_name); }

static inline void bam_header_destroy(bam_header_t *header) { bam_hdr_destroy(header); }
static inline bam_header_t *bam_header_read(bamFile fp) { return bam_hdr_read(fp); }

typedef hts_idx_t bam_index_t;

static inline void bam_index_destroy(bam_index_t *idx) { hts_idx_destroy(idx); }

typedef int (*bam_fetch_f)(const bam1_t *b, void *data);

static inline bam_iter_t bam_iter_query(const bam_index_t *idx, int tid, int beg, int end) { return bam_itr_queryi(idx, tid, beg, end); }
static inline int bam_iter_read(bamFile fp, bam_iter_t iter, bam1_t *b) { return iter? hts_itr_next(fp, iter, b, 0) : bam_read1(fp, b); }
static inline void bam_iter_destroy(bam_iter_t iter) { bam_itr_destroy(iter); }

static inline uint32_t bam_calend(const bam1_core_t *c, const uint32_t *cigar) { return c->pos + (c->n_cigar? bam_cigar2rlen(c->n_cigar, cigar) : 1); }

/* Defined in samtools-1.7/bam.c and gone in samtools-1.18 */

static inline int bam_fetch(bamFile fp, const bam_index_t *idx, int tid, int beg, int end, void *data, bam_fetch_f func)
{
    int ret;
    bam_iter_t iter;
    bam1_t *b;
    b = bam_init1();
    iter = bam_iter_query(idx, tid, beg, end);
    while ((ret = bam_iter_read(fp, iter, b)) >= 0) func(b, data);
    bam_iter_destroy(iter);
    bam_destroy1(b);
    return (ret == -1)? 0 : ret;
}

/* Defined in samtools-1.7/sam.h and gone in samtools-1.18 */

typedef struct {
    samFile *file;
    struct { BGZF *bam; } x;  // Hack so that fp->x.bam still works
    bam_hdr_t *header;
    unsigned short is_write:1;
} samfile_t;

static inline int samread(samfile_t *fp, bam1_t *b) { return sam_read1(fp->file, fp->header, b); }
static inline int samwrite(samfile_t *fp, const bam1_t *b) { return sam_write1(fp->file, fp->header, b); }

/* Defined in samtools-1.7/sam.c and gone in samtools-1.18 */

static inline samfile_t *samopen(const char *fn, const char *mode, const void *aux)
{
    // hts_open() is really sam_open(), except for #define games
    samFile *hts_fp = hts_open(fn, mode);
    if (hts_fp == NULL)  return NULL;

    samfile_t *fp = (samfile_t *) malloc(sizeof (samfile_t));
    if (!fp) {
        sam_close(hts_fp);
        return NULL;
    }
    fp->file = hts_fp;
    fp->x.bam = hts_fp->fp.bgzf;
    if (strchr(mode, 'r')) {
        if (aux) {
            if (hts_set_fai_filename(fp->file, (const char *) aux) != 0) {
                sam_close(hts_fp);
                free(fp);
                return NULL;
            }
        }
        fp->header = sam_hdr_read(fp->file);  // samclose() will free this
        if (fp->header == NULL) {
            sam_close(hts_fp);
            free(fp);
            return NULL;
        }
        fp->is_write = 0;
        if (fp->header->n_targets == 0 && bam_verbose >= 1)
            fprintf(stderr, "[samopen] no @SQ lines in the header.\n");
    }
    else {
        enum htsExactFormat fmt = hts_get_format(fp->file)->format;
        fp->header = (bam_hdr_t *)aux;  // For writing, we won't free it
        fp->is_write = 1;
        if (!(fmt == text_format || fmt == sam) || strchr(mode, 'h')) {
            if (sam_hdr_write(fp->file, fp->header) < 0) {
                if (bam_verbose >= 1)
                    fprintf(stderr, "[samopen] Couldn't write header\n");
                sam_close(hts_fp);
                free(fp);
                return NULL;
            }
        }
    }

    return fp;
}

static inline void samclose(samfile_t *fp)
{
    if (fp) {
        if (!fp->is_write && fp->header) bam_hdr_destroy(fp->header);
        sam_close(fp->file);
        free(fp);
    }
}

static inline int sampileup(samfile_t *fp, int mask, bam_pileup_f func, void *func_data)
{
    bam_plbuf_t *buf;
    int ret;
    bam1_t *b;
    b = bam_init1();
    buf = bam_plbuf_init(func, func_data);
    if (mask < 0) mask = BAM_FUNMAP | BAM_FSECONDARY | BAM_FQCFAIL | BAM_FDUP;
    else mask |= BAM_FUNMAP;
    while ((ret = samread(fp, b)) >= 0) {
        // bam_plp_push() itself now filters out unmapped reads only
        if (b->core.flag & mask) b->core.flag |= BAM_FUNMAP;
        bam_plbuf_push(b, buf);
    }
    bam_plbuf_push(0, buf);
    bam_plbuf_destroy(buf);
    bam_destroy1(b);
    return 0;
}

/* Defined in samtools-1.7/bam_aux.c and gone in samtools-1.18 */

static inline int bam_parse_region(bam_header_t *header, const char *str, int *ref_id, int *beg, int *end)
{
    const char *name_lim = hts_parse_reg(str, beg, end);
    if (name_lim) {
        char *name = (char *) malloc(name_lim - str + 1);
        memcpy(name, str, name_lim - str);
        name[name_lim - str] = '\0';
        *ref_id = bam_name2id(header, name);
        free(name);
    }
    else {
        // not parsable as a region, but possibly a sequence named "foo:a"
        *ref_id = bam_name2id(header, str);
        *beg = 0; *end = INT_MAX;
    }
    if (*ref_id == -1) return -1;
    return *beg <= *end? 0 : -1;
}

#endif // SAMTOOLS_1_7_COMPAT_H
