pkgconfig <- function(opt=c("PKG_LIBS", "PKG_CPPFLAGS"))
{
    opt <- match.arg(opt)
    if (opt == "PKG_LIBS") {
        usrlib_dir <- Sys.getenv(
            "RHTSLIB_RPATH",
            system.file("usrlib", package="Rhtslib", mustWork=TRUE)
        )
        platform <- Sys.info()[["sysname"]]
        if (platform == "Windows")
            usrlib_dir <- file.path(usrlib_dir, .Platform[["r_arch"]])
        ## See how PKG_LIBS is defined in Rhtslib/src/Makevars.common
        ## and make sure to produce the same value here.
        config <- sprintf('%s -lcurl', file.path(usrlib_dir, "libhts.a"))
    } else {
        ## See how PKG_CPPFLAGS is defined in Rhtslib/src/Makevars.common
        ## and make sure to produce the same value here.
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

