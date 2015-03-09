#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.67])
AC_INIT([HTSlib], [VERSION], [BUG-REPORT-ADDRESS])
AM_INIT_AUTOMAKE([foreign subdir-objects])
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
# gnulib-tool --import alloca arpa_inet fcntl fdatasync getpagesize inttypes netdb stat-size stddef stdint stdlib string sys_select sys_socket sys_stat sys_time unistd recv send
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
