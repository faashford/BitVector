import XCTest
@testable import BitVector

final class BitVectorInitTests: XCTestCase {
    func testDefaultInitNotNil() {
        // 1. given
        let testBV:BitVector
        // 2. when
        testBV = BitVector()
        // 3. then
        XCTAssertNotNil(testBV)
    }
    func testDefaultInitCountIs64() {
        // 1. given
        var result = true
        let testBV:BitVector
        let defaultBitVectorLength = 64
        // 2. when
        testBV = BitVector()
        // 3. then
        if defaultBitVectorLength != CFBitVectorGetCount(testBV.bv) && defaultBitVectorLength != testBV.count {
            result = false
        }
        XCTAssertTrue(result)
    }
}

final class BitVectorBitGetSetTests: XCTestCase {
    func testSetGet() {
        // 1. given
        // M is an existing test vector
        let testBV:BitVector
        let defaultBitVectorLength = 64
        var result = true
        // 2. when
        testBV = BitVector(size: defaultBitVectorLength)
        for index in 0..<defaultBitVectorLength {
            testBV.setBit(index: index, value: M[index])
        }
        // 3. then
        for index in 0..<defaultBitVectorLength {
            if M[index] != testBV.getBit(index: index) {
                result = false
            }
        }
        XCTAssertTrue(result)
    }
}

final class BitVectorSequenceProtocolTests: XCTestCase {
}

final class RangeReplaceableCollectionProtocolTests: XCTestCase {
    func testAppendOperator() {
        // 1. given
        var testBV1:BitVector
        var testBV2:BitVector
        var testBV3:BitVector
        var result = true
        let size = 8
        // 2. when
        testBV1 = BitVector(size: size)
        testBV2 = BitVector(size: size)
        testBV3 = BitVector(size: size)
        for i in 0..<size {
            testBV1[i] = small1[i]
            testBV2[i] = small2[i]
            testBV3[i] = small1[i]
        }
        let out = testBV1 + testBV2 + testBV3
        // 3. then
        for i in 0..<8 {
            if out[i] != testBV1[i] || out[i+8] != testBV2[i] || out[i+16] != testBV3[i] {
                result = false
            }
        }
        XCTAssertTrue(result)
    }
    
}
