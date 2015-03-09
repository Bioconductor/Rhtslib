lib_LTLIBRARIES = libhts.la
noinst_LTLIBRARIES = lib/libgnu.la

# allows 'make (bgzip|htsfile|tabix|libhts.la)' instead of relying on
# making all.
lib/libgnu.la:
	cd ./lib && $(MAKE) $(AM_MAKEFLAGS) && cd ..

libhts_la_CPPFLAGS = -Ihtslib -Icram $(AM_CPPFLAGS)

libhts_la_LIBADD = lib/libgnu.la
libhts_la_LDFLAGS = $(LIBSOCKET) $(LIB_FDATASYNC) -no-undefined

bin_PROGRAMS = bgzip htsfile tabix

AM_CPPFLAGS = -I$(top_srcdir)/lib -I$(top_srcdir)/htslib
AM_LDADD = $(top_srcdir)/lib/libgnu.la $(LIBSOCKET) $(LIB_FDATASYNC)

bgzip_LDADD = $(top_srcdir)/libhts.la $(AM_LDADD)
bgzip_SOURCES = bgzip.c

htsfile_LDADD = $(top_srcdir)/libhts.la $(AM_LDADD)
htsfile_SOURCES = htsfile.c

tabix_LDADD = $(top_srcdir)/libhts.la $(AM_LDADD)
tabix_SOURCES = tabix.c

SUBDIRS = lib test
ACLOCAL_AMFLAGS = -I m4
EXTRA_DIST = m4/gnulib-cache.m4

TESTS = run_tests.sh

libhts_la_SOURCES = \
kfunc.c \
knetfile.c \
kstring.c \
bgzf.c \
faidx.c \
hfile.c \
hfile_net.c \
hts.c \
regidx.c \
sam.c \
synced_bcf_reader.c \
vcf_sweep.c \
tbx.c \
vcf.c \
vcfutils.c \
cram/cram_codecs.c \
cram/cram_decode.c \
cram/cram_encode.c \
cram/cram_index.c \
cram/cram_io.c \
cram/cram_samtools.c \
cram/cram_stats.c \
cram/files.c \
cram/mFILE.c \
cram/md5.c \
cram/open_trace_file.c \
cram/pooled_alloc.c \
cram/rANS_static.c \
cram/sam_header.c \
cram/string_alloc.c \
cram/thread_pool.c \
cram/vlen.c \
cram/zfio.c

include_HEADERS = \
htslib/bgzf.h \
htslib/faidx.h \
htslib/hfile.h \
htslib/hts.h \
htslib/hts_defs.h \
htslib/khash.h \
htslib/klist.h \
htslib/knetfile.h \
htslib/kseq.h \
htslib/ksort.h \
htslib/kstring.h \
htslib/regidx.h \
htslib/sam.h \
htslib/synced_bcf_reader.h \
htslib/tbx.h \
htslib/vcf.h \
htslib/vcf_sweep.h \
htslib/vcfutils.h