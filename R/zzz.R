pkgconfig <- function(opt=c("PKG_LIBS", "PKG_CPPFLAGS"))
{
    opt <- match.arg(opt)
    if (opt == "PKG_LIBS") {
        usrlib_dir <- Sys.getenv(
            "RHTSLIB_RPATH",
            system.file("usrlib", package="Rhtslib", mustWork=TRUE)
        )
        platform <- Sys.info()[["sysname"]]
        if (platform == "Windows") {
            usrlib_dir <- sprintf("%s/%s", usrlib_dir, .Platform[["r_arch"]])
            ## See how 'htslib_default_libs' is defined in
            ## htslib-1.7/Makefile.Rhtslib.win and make sure
            ## to use the same value here.
            htslib_default_libs <- "-lz -lm -lws2_32"
            config <- sprintf('-L"%s" -lhts %s -lpthread',
                              usrlib_dir, htslib_default_libs)
        } else {
            if (platform == "Darwin") {
                config <- sprintf('%s/libhts.a', usrlib_dir)
            } else {
                ## See how 'htslib_default_libs' is defined in
                ## htslib-1.7/Makefile.Rhtslib and make sure
                ## to use the same value here.
                htslib_default_libs <- "-lz -lm -lbz2 -llzma"

                ## Dynamic linking seems to cause problems on some Linux
                ## systems. See https://support.bioconductor.org/p/120529/
                ## Mike's fix is to use linker option --disable-new-dtags:
                ##   https://github.com/Bioconductor/Rhtslib/pull/5
                ## Another way to go is to just link statically.

                ## Cause problems on some Linux systems:
                #config <- sprintf('-L%s -Wl,-rpath,%s -lhts %s -lpthread',
                #                  usrlib_dir, usrlib_dir, htslib_default_libs)

                ## Using linker option --disable-new-dtags seems to solve
                ## the problem:
                #config <- sprintf('-L%s %s -Wl,-rpath,%s -lhts %s -lpthread',
                #                  usrlib_dir, "-Wl,--disable-new-dtags",
                #                  usrlib_dir, htslib_default_libs)

                ## However, static linking is probably safer:
                config <- sprintf('%s/libhts.a %s -lpthread',
                                  usrlib_dir, htslib_default_libs)
            }
        }
    } else {
        include_dir <- system.file("include", package="Rhtslib")
        config <- sprintf('-I"%s"', include_dir)
    }
    cat(config)
}

htsVersion <- function()
{
    vers <- .Call("Rhtslib_htslib_version", PACKAGE="Rhtslib")
    message(vers)
}

.onAttach <- function(...)
{
    vers <- .Call("Rhtslib_htslib_version", PACKAGE="Rhtslib")
    packageStartupMessage("Rhtslib htslib version ", vers)
}

