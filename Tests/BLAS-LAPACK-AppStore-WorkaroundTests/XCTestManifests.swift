import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BLAS_LAPACK_AppStore_WorkaroundTests.allTests),
    ]
}
#endif
