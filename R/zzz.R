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
        usrlib_path <- sprintf("'%s'", file.path(usrlib_dir, "libhts.a"))
        if (platform == "Windows") {
            ## See how PKG_LIBS is defined in Rhtslib/src/Makevars.win
            ## and make sure to produce the same value here.
            libs <- c("z", "m", "bz2", "lzma", "curl", "bcrypt", "idn2", "unistring",
                      "iconv", "ssl", "crypto", "crypt32", "wsock32",
                      "wldap32", "ssh2", "gcrypt", "gpg-error", "ws2_32",
                      "zstd", "regex")
            libs <- paste(sprintf("-l%s", libs), collapse=" ")
        } else {
            ## See how PKG_LIBS is defined in Rhtslib/src/Makevars
            ## and make sure to produce the same value here.
            libs <- "-lcurl"
        }
        config <- paste(usrlib_path, libs)
    } else {
        ## See how PKG_CPPFLAGS is defined in Rhtslib/src/Makevars.common
        ## and make sure to produce the same value here.
        config <- "-D_FILE_OFFSET_BITS=64"
        ## Packages that link to Rhtslib should have Rhtslib in their
        ## LinkingTo field so the preprocessor option below will automatically
        ## be added. There is no need to add it again here.
        #include_dir <- system.file("include", package="Rhtslib")
        #config <- paste(config, sprintf("-I'%s'", include_dir))
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

