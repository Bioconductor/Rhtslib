# Makefile.am for htslib, a C library for high-throughput sequencing
# data formats.
#
# The MIT/Expat License
#
#    Copyright (C) 2015 Bioconductor
#
#    Author: Nathaniel Hayden <nhayden@fredhutch.org>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

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
	htslib/kfunc.h \
	htslib/khash.h \
	htslib/khash_str2int.h \
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

man1_MANS = \
	tabix.1

man5_MANS = \
	faidx.5 \
	sam.5 \
	vcf.5
