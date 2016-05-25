pkgconfig <-
    function(opt = c("PKG_LIBS", "PKG_CPPFLAGS"))
{
    path <- system.file("lib", package="Rhtslib", mustWork=TRUE)
    if (nzchar(.Platform$r_arch)) {
        arch <- sprintf("/%s", .Platform$r_arch)
    } else {
        arch <- ""
    }
    patharch <- paste0(path, arch)

    result <- switch(match.arg(opt), PKG_CPPFLAGS={
        sprintf('-I"%s"', system.file("include", package="Rhtslib"))
    }, PKG_LIBS={
        switch(Sys.info()['sysname'], Linux={
            sprintf('-L%s -Wl,-rpath,%s -lhts -lz -pthread',
                    patharch, patharch)
        }, Darwin={
            sprintf('%s/libhts.a -lz -pthread', patharch)
        }, Windows={
            sprintf('-L"%s" -lhts -lz -pthread -lws2_32', patharch)
        }
    )})

    cat(result)
}

htsVersion <- function() {
    vers <- .Call("Rhtslib_htslib_version", PACKAGE="Rhtslib")
    message(vers)
}

.onAttach <-
    function(...)
{
    vers <- .Call("Rhtslib_htslib_version", PACKAGE="Rhtslib")
    packageStartupMessage("Rhtslib htslib version ", vers)
}
