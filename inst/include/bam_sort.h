/* === BEGIN BIOCONDUCTOR PATCH ===

IMPORTANT NOTE: samtoools provides no bam_sort.h header file!
However Rsamtools/src/io_sam.c calls the bam_sort_core_ext() function
defined in bam_sort.c so needs access to the function prototype. So we
create a minimalist header file, just to support that.
*/
#ifndef BAM_SORT_H
#define BAM_SORT_H

#include <stdbool.h>
#include "htslib/hts.h"

typedef enum {Coordinate, QueryName, TagCoordinate, TagQueryName, MinHash, TemplateCoordinate} SamOrder;

int bam_sort_core_ext(SamOrder sam_order, char* sort_tag, int minimiser_kmer,
                      bool try_rev, bool no_squash, const char *fn,
                      const char *prefix, const char *fnout,
                      const char *modeout, size_t _max_mem, int n_threads,
                      const htsFormat *in_fmt, const htsFormat *out_fmt,
                      char *arg_list, int no_pg, int write_index);

#endif
/* === END BIOCONDUCTOR PATCH === */
