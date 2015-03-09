check_PROGRAMS = fieldarith hfile sam test-regidx test_view \
		 test-vcf-api test-vcf-sweep

TESTCPPFLAGS = -I$(top_srcdir)/htslib -I$(top_srcdir)/lib -I$(top_srcdir)/cram
TESTLDADD = $(top_srcdir)/libhts.la $(top_srcdir)/lib/libgnu.la $(LIBSOCKET) $(LIB_FDATASYNC)

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

