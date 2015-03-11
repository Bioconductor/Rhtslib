# Makefile.am for htslib tests
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

check_PROGRAMS = fieldarith hfile sam test-regidx test_view \
	test-vcf-api test-vcf-sweep

TESTCPPFLAGS = -I$(top_srcdir)/htslib -I$(top_srcdir)/lib -I$(top_srcdir)/cram
TESTLDADD = $(top_srcdir)/libhts.la $(top_srcdir)/lib/libgnu.la \
	$(LIBSOCKET) $(LIB_FDATASYNC)

fieldarith_SOURCES = fieldarith.c
fieldarith_CPPFLAGS = $(TESTCPPFLAGS)
fieldarith_LDADD = $(TESTLDADD)

hfile_SOURCES = hfile.c
hfile_CPPFLAGS = $(TESTCPPFLAGS)
hfile_LDADD = $(TESTLDADD)

sam_SOURCES = sam.c
sam_CPPFLAGS = $(TESTCPPFLAGS)
sam_LDADD = $(TESTLDADD)

test_regidx_SOURCES = test-regidx.c
test_regidx_CPPFLAGS = $(TESTCPPFLAGS)
test_regidx_LDADD = $(TESTLDADD)

test_view_SOURCES = test_view.c
test_view_CPPFLAGS = $(TESTCPPFLAGS)
test_view_LDADD = $(TESTLDADD)

test_vcf_api_SOURCES = test-vcf-api.c
test_vcf_api_CPPFLAGS = $(TESTCPPFLAGS)
test_vcf_api_LDADD = $(TESTLDADD)

test_vcf_sweep_SOURCES = test-vcf-sweep.c
test_vcf_sweep_CPPFLAGS = $(TESTCPPFLAGS)
test_vcf_sweep_LDADD = $(TESTLDADD)

