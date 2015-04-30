# Configure script for htslib, a C library for high-throughput sequencing
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

dnl Process this file with autoconf to produce a configure script.

AC_PREREQ([2.67])
AC_INIT([HTSlib], [1.1], [samtools-help@lists.sourceforge.net], [],
        [http://www.htslib.org/])
AM_INIT_AUTOMAKE([foreign subdir-objects])
AM_MAINTAINER_MODE([enable])
AC_USE_SYSTEM_EXTENSIONS
LT_INIT
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_SRCDIR([synced_bcf_reader.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC
gl_EARLY
gl_INIT
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MKDIR_P

# Checks for libraries.
AC_SEARCH_LIBS([pthread_create], [pthread])
AC_CHECK_LIB([m], [cos])

dnl allow arbitrary zlib name and test function
zlib_name=z
AC_ARG_WITH([zlib-name],
    [AS_HELP_STRING([--with-zlib-name=ZNAME], [use zlib named ZNAME])],
    [case x$withval in
        xno)  AC_MSG_WARN([HTSlib requires zlib; using default zlib name]) ;;
        xyes) ;;
        x)    ;;
        *)    zlib_name="$withval" ;;
     esac]
)

zlib_testfunc=zlibVersion
AC_ARG_WITH([zlib-testfunc],
    [AS_HELP_STRING([--with-zlib-testfunc=ZTESTFUNC],
        [use ZTESTFUNC to test presence of zlib])],
    [case x$withval in
        xno)  AC_MSG_WARN([using default test function to probe $zlib_name]) ;;
        xyes) ;;
        x)    ;;
        *)    zlib_testfunc="$withval" ;;
     esac]
)
AC_CHECK_LIB([$zlib_name], [$zlib_testfunc])

# Checks for header files.

# Ran the following gnulib import statement (limits is not a module):
#gnulib-tool --no-vc-files --lgpl=2 --libtool --import alloca arpa_inet fcntl fdatasync getpagesize inttypes netdb stddef stdint stdlib string sys_select sys_socket sys_stat sys_time unistd recv send
AC_CHECK_HEADERS([alloca.h arpa/inet.h fcntl.h inttypes.h limits.h \
netdb.h stddef.h stdint.h stdlib.h string.h sys/select.h sys/socket.h \
sys/stat.h sys/time.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_INLINE
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_INT8_T
AC_TYPE_OFF_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_CHECK_MEMBERS([struct stat.st_blksize])
AC_HEADER_STDBOOL
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_TYPE_UINT8_T

# Checks for library functions.
AC_FUNC_ALLOCA
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FSEEKO
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_FUNC_STRTOD
AC_CHECK_FUNCS([atexit fdatasync floor ftruncate getcwd gethostbyaddr gethostbyname getpagesize gettimeofday memmove memset mkdir select socket strcasecmp strchr strdup strerror strrchr strstr strtol strtoul])

AC_CONFIG_FILES([Makefile
                 test/Makefile
                 lib/Makefile])
AC_OUTPUT
