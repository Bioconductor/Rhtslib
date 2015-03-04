\name{Rhtslib-package}
\alias{Rhtslib-package}
\alias{Rhtslib}
\alias{htsVersion}

\docType{package}
\title{
    An R packaged HTSlib 1.1
}
\description{

    This package is interesting to package developers only, and provides
    a compiled HTSlib for developers to use in their own packages. See
    the vignette for instructions on use.

}
\details{

    Instructions for use are in the vignette, available with
    \code{browseVignettes(package="Rhtslib")}

}

\seealso{\link{pkgconfig}}

\author{Nathaniel Hayden \url{nhayden@fredhutch.org}}

\references{

    The HTSlib included in the package is based on release 1.1 of HTSlib
    found in the GitHub repository at
    \url{https://github.com/samtools/htslib}

}

\keyword{ package }
\examples{
packageDescription('Rhtslib')
Rhtslib:::htsVersion()
}
