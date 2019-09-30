#if !canImport(ObjectiveC)
import XCTest

extension ComponentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ComponentTests = [
        ("testComponentIdentifier", testComponentIdentifier)
    ]
}

extension EntityTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EntityTests = [
        ("testEntityIdentifierAndIndex", testEntityIdentifierAndIndex)
    ]
}

extension FamilyTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FamilyTests = [
        ("testFamilyAbandoned", testFamilyAbandoned),
        ("testFamilyBulkDestroy", testFamilyBulkDestroy),
        ("testFamilyCreation", testFamilyCreation),
        ("testFamilyExchange", testFamilyExchange),
        ("testFamilyLateMember", testFamilyLateMember),
        ("testFamilyMemberBasicIteration", testFamilyMemberBasicIteration),
        ("testFamilyReuse", testFamilyReuse)
    ]
}

extension FamilyTraitsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FamilyTraitsTests = [
        ("testTraitCommutativity", testTraitCommutativity),
        ("testTraitMatching", testTraitMatching)
    ]
}

extension HashingTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__HashingTests = [
        ("testCollisionsInCritialRange", testCollisionsInCritialRange)
    ]
}

extension NexusTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NexusTests = [
        ("testComponentCreation", testComponentCreation),
        ("testComponentDeletion", testComponentDeletion),
        ("testComponentRetrieval", testComponentRetrieval),
        ("testComponentUniqueness", testComponentUniqueness),
        ("testEntityCreate", testEntityCreate),
        ("testEntityDestroy", testEntityDestroy)
    ]
}

extension SingleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SingleTests = [
        ("testSingleCreation", testSingleCreation),
        ("testSingleCreationOnExistingFamilyMember", testSingleCreationOnExistingFamilyMember),
        ("testSingleEntityAndComponentCreation", testSingleEntityAndComponentCreation),
        ("testSingleReuse", testSingleReuse)
    ]
}

extension SparseSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SparseSetTests = [
        ("testSparseSetAdd", testSparseSetAdd),
        ("testSparseSetAddAndReplace", testSparseSetAddAndReplace),
        ("testSparseSetClear", testSparseSetClear),
        ("testSparseSetDoubleRemove", testSparseSetDoubleRemove),
        ("testSparseSetGet", testSparseSetGet),
        ("testSparseSetNonCongiuousData", testSparseSetNonCongiuousData),
        ("testSparseSetReduce", testSparseSetReduce),
        ("testSparseSetRemove", testSparseSetRemove),
        ("testSparseSetRemoveAndAdd", testSparseSetRemoveAndAdd),
        ("testSparseSetRemoveNonPresent", testSparseSetRemoveNonPresent),
        ("testStartEndIndex", testStartEndIndex),
        ("testSubscript", testSubscript)
    ]
}

extension SystemsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SystemsTests = [
        ("testSystemsUpdate", testSystemsUpdate)
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ComponentTests.__allTests__ComponentTests),
        testCase(EntityTests.__allTests__EntityTests),
        testCase(FamilyTests.__allTests__FamilyTests),
        testCase(FamilyTraitsTests.__allTests__FamilyTraitsTests),
        testCase(HashingTests.__allTests__HashingTests),
        testCase(NexusTests.__allTests__NexusTests),
        testCase(SingleTests.__allTests__SingleTests),
        testCase(SparseSetTests.__allTests__SparseSetTests),
        testCase(SystemsTests.__allTests__SystemsTests)
    ]
}
#endif
