#include <Rinternals.h>
#include "htslib/version.h"

SEXP Rhtslib_htslib_version()
{
    return Rf_ScalarString(Rf_mkChar(HTS_VERSION));
}

#include <R_ext/Rdynload.h>

R_CallMethodDef callMethods[] = {
    {"Rhtslib_htslib_version", (DL_FUNC) &Rhtslib_htslib_version, 0},
    {NULL, NULL, 0}
};

void R_init_Rhtslib(DllInfo *info)
{
    R_registerRoutines(info, NULL, callMethods, NULL, NULL);
}
