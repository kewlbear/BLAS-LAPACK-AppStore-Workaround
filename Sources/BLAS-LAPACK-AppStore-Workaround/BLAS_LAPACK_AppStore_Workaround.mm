//
//  BLAS_LAPACK_AppStore_Workaround.mm
//
//  Copyright (c) 2021 Changbeom Ahn
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Accelerate/Accelerate.h>

#define sgemm_ sgemm_workaround
#define FINTEGER int

#define lapack_int     __CLPK_integer
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
    lapack_int n = 1;
    return lsamen_(&n, ca, cb);
}

}
