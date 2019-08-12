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
            r_arch <- .Platform[["r_arch"]]
            usrlib_dir <- file.path(usrlib_dir, r_arch)
        }
        config <- file.path(usrlib_dir, "libhts.a")
        if (platform == "Windows") {
            ## See how PKG_LIBS is defined in Rhtslib/src/Makevars.win
            ## and make sure to produce the same value here.
            libs <- c("curl", "rtmp", "ssl", "ssh2", "crypto",
                      "gdi32", "z", "ws2_32", "wldap32", "winmm")
            if (r_arch == "i386")
                libs <- c(libs, "idn")
            libs <- paste(sprintf("-l%s", libs), collapse=" ")
            config <- sprintf("%s -LC:/extsoft/lib/%s %s", config, r_arch, libs)
        } else {
            ## See how PKG_LIBS is defined in Rhtslib/src/Makevars
            ## and make sure to produce the same value here.
            config <- sprintf("%s -lcurl", config)
        }
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

