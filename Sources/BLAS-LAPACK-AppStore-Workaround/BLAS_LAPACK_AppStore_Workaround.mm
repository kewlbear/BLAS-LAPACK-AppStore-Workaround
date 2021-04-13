#import <Accelerate/Accelerate.h>

#define sgemm_ sgemm_workaround
#define FINTEGER int

#define lapack_int     int
#define lapack_logical lapack_int
#define LAPACK_lsame lsame_workaround

static const enum CBLAS_TRANSPOSE trans(const char *s)
{
    auto c = toupper(*s);
    switch (c) {
        case 'N':
            return CblasNoTrans;

        case 'T':
            return CblasTrans;
            
        case 'C':
            return CblasConjTrans;
            
        default:
            abort(); // FIXME: cblas_xerbla?
    }
}

extern "C" {

int sgemm_ (const char *transa, const char *transb, FINTEGER *m, FINTEGER *
            n, FINTEGER *k, const float *alpha, const float *a,
            FINTEGER *lda, const float *b, FINTEGER *
            ldb, float *beta, float *c, FINTEGER *ldc)
{
    cblas_sgemm(CblasColMajor, trans(transa), trans(transb), *m, *n, *k, *alpha, a, *lda, b, *ldb, *beta, c, *ldc);
    return 0;
}

lapack_logical LAPACK_lsame( char* ca,  char* cb,
                              lapack_int lca, lapack_int lcb )
{
    int n = 1;
    return lsamen_(&n, ca, cb);
}

}
