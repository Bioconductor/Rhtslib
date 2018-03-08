pkgconfig <- function(opt=c("PKG_LIBS", "PKG_CPPFLAGS"))
{
    usrlib <- Sys.getenv(
        "RHTSLIB_RPATH",
        system.file("usrlib", package="Rhtslib", mustWork=TRUE)
    )
    if (nzchar(.Platform$r_arch)) {
        arch <- sprintf("/%s", .Platform$r_arch)
    } else {
        arch <- ""
    }
    usrlib_arch <- paste0(usrlib, arch)

    ## Same as htslib_default_libs variable defined in htslib-1.7/Makefile:
    htslib_default_libs <- "-lz -lm -lbz2 -llzma"

    result <- switch(match.arg(opt),
        PKG_CPPFLAGS={
            sprintf('-I"%s"', system.file("include", package="Rhtslib"))
        },
        PKG_LIBS={
            switch(Sys.info()[["sysname"]],
                Linux={
                    sprintf('-L%s -Wl,-rpath,%s -lhts %s -pthread',
                            usrlib_arch, usrlib_arch, htslib_default_libs)
                },
                Darwin={
                    sprintf('%s/libhts.a %s -lcurl -lpthread',
                            usrlib_arch, htslib_default_libs)
                },
                Windows={
                    sprintf('-L"%s" -lhts -lz -pthread -lws2_32', usrlib_arch)
                })
        })

    cat(result)
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

