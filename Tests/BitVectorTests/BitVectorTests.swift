import XCTest
@testable import BitVector

final class BitVectorInitTests: XCTestCase {
    func testInitWithString() {
        // 1. given
        // a_h
        let testBV:BitVector
        var result = true
        // 2. when
        testBV = BitVector(block: a_h)
        for i in 0..<64 {
            let answer = a_hBits[i]
            let value = CFBitVectorGetBitAtIndex(testBV.bv,i)
            if answer != value {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
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
        if defaultBitVectorLength != CFBitVectorGetCount(testBV.bv) && defaultBitVectorLength != testBV.getCount() {
            result = false
        }
        XCTAssertTrue(result)
    }
    func testUInt8InitNotNil() {
        // 1. given
        let testBV:BitVector
        // 2. when
        testBV = BitVector(bits: M)
        // 3. then
        XCTAssertNotNil(testBV)
    }
    func testUInt8InitCountIs64() {
        // 1. given
        let testBV:BitVector
        var result = true
        let defaultBitVectorLength = 64
        // 2. when
        testBV = BitVector(bits: M)
        // 3. then && defaultBitVectorLength != testBV.count
        if defaultBitVectorLength != CFBitVectorGetCount(testBV.bv) && defaultBitVectorLength != testBV.getCount() {
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
            testBV.setBit(index: index, value: CFBit(M[index]))
        }
        // 3. then
        for index in 0..<defaultBitVectorLength {
            if M[index] != testBV.getBit(index: index) {
                result = false
            }
        }
        XCTAssertTrue(result)
    }
    func testGetData() {
        // 1. given
        // M is an existing test array
        var result = true
        let testBV:BitVector
        // 2. when
        testBV = BitVector(bits: M)
        // 3. then
        let x = testBV.getData()
        for index in 0..<64 {
            if x.bits[index] != M[index] {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
}

final class BitVectorSequenceProtocolTests: XCTestCase {
    func testSequenceIteration () {
        // 1. given
        var testBV: BitVector
        var result = true
        // 2. when
        testBV = BitVector(bits: M)
        // 3. then
        for (i, bit) in testBV.enumerated() {
            if M[i] != bit {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
    func testPrefix() {
        // 1. given
        var testBV: BitVector
        var result = true
        // 2. when
        testBV = BitVector(bits: M)
        let prefix16 = testBV.prefix(16)
        // 3. then
        for i in 0..<16 {
            if M[i] != prefix16[i] {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }

}

final class RangeReplaceableCollectionProtocolTests: XCTestCase {
    func testAppendOperator() {
        // 1. given
        let testBV1:BitVector = BitVector(bits: M)
        let testBV2:BitVector = BitVector(bits: K)
        let testBV3:BitVector = BitVector(bits: K_plus)
        var result = true
        var message = ""
        // 2. when
        let out = testBV1 + testBV2 + testBV3
        // 3. then
        for i in 0..<(testBV1.count+testBV2.count+testBV3.count) {
            if testBV1[i] != out[i] {
                result = false
                message = "testBV1 comparison failed"
                break
            }
            if testBV2[i] != out[i+testBV1.count] {
                result = false
                message = "testBV2 comparison failed"
                break
            }
            if testBV3[i] != out[i+testBV1.count+testBV2.count] {
                result = false
                message = "testBV3 comparison failed"
                break
            }
        }
        XCTAssertTrue(result, message)
    }
    
}

final class BitVectorCollectionProtocolTests : XCTestCase {
    func testSubscriptIteration() {
        // 1. given
        var testBV: BitVector
        var result = true
        // 2. when
        testBV = BitVector(bits: M)
        // 3. then
        for (i, bit) in testBV.enumerated() {
            if M[i] != bit {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
    func testCount() {
        // 1. given
        var testBV: BitVector
        var result = true
        // 2. when
        testBV = BitVector(bits: M)
        // 3. then
        if 64 != testBV.count {
            result = false
        }
        XCTAssertTrue(result)
    }
}

final class BitVectorBitwiseOperationsProtocolTests : XCTestCase {
    func testBitwiseOr() {
        // 1. given
        let testBV: BitVector = BitVector(bits: bitwiseOpsConstant05)
        let zeroBV: BitVector = BitVector(bits: bitwiseOpsConstant00)
        let answerBV: BitVector = testBV
        var result = true
        // 2. when
        let out = testBV | zeroBV
        // 3. then
        for i in 0..<testBV.count {
            if answerBV[i] != out[i] {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
    func testBitwiseXOR() {
        // 1. given
        let testBV: BitVector = BitVector(bits: bitwiseOpsConstant05)
        let zeroBV: BitVector = BitVector(bits: bitwiseOpsConstant00)
        var result = true
        // 2. when
        let out = testBV ^ zeroBV
        // 3. then
        for i in 0..<testBV.count {
            if testBV[i] != out[i] {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
    func testBitwiseAND() {
        // 1. given
        let testBV: BitVector = BitVector(bits: bitwiseOpsConstant05)
        let zeroBV: BitVector = BitVector(bits: bitwiseOpsConstant00)
        var result = true
        // 2. when
        let out = testBV & zeroBV
        // 3. then
        for i in 0..<testBV.count {
            if zeroBV[i] != out[i] {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
    func testBitwiseNOTAND() {
        // 1. given
        let testBV: BitVector = BitVector(bits: bitwiseOpsConstant05)
        let zeroBV: BitVector = BitVector(bits: bitwiseOpsConstant00)
        var result = true
        // 2. when
        let out = testBV & ~zeroBV
        // 3. then
        for i in 0..<testBV.count {
            if testBV[i] != out[i] {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
    func testBitwiseNOTXOR() {
        // 1. given
        let testBV: BitVector = BitVector(bits: bitwiseOpsConstant05)
        let zeroBV: BitVector = BitVector(bits: bitwiseOpsConstant00)
        var result = true
        // 2. when
        let out = testBV ^ ~zeroBV
        let notTestBV = ~testBV
        // 3. then
        for i in 0..<testBV.count {
            if notTestBV[i] != out[i] {
                result = false
                break
            }
        }
        XCTAssertTrue(result)
    }
}

final class TestBitVectorSpecificOperations : XCTestCase {
    func testPermutedVector() {
        // 1. given
        let testBV: BitVector = BitVector(bits: M)
        let pv = IP.map({$0 - 1})
        var result = true
        var message = ""
        // 2. when
        let permuted = testBV.permuted(with: pv)
        // 3. then
        if pv.count != permuted.count {
            result = false
            message += "failed to count properly, "
        }
        for i in 0..<permuted.count {
            if M_permutedByIP[i] != permuted[i] {
                result = false
                message += "bits don't match"
                break
            }
        }
        XCTAssertTrue(result, message)
    }
    func testPermutedCount() {
        // 1. given
        let testBV: BitVector = BitVector(bits: M)
        let pv = IP.map({$0 - 1})
        var result = true
        // 2. when
        let permuted = testBV.permuted(with: pv)
        // 3. then
        if pv.count != permuted.count {
            result = false
        }
        XCTAssertTrue(result)
    }
    func testHalved() {
        // 1. given
        let testBV:BitVector = BitVector(bits: K_plus)
        var result = true
        var message = ""
        // 2. when
        let answer = testBV.halved()
        // 3. then
        for i in 0..<C0.count {
            if C0[i] != answer.0[i] {
                result = false
                message += "problem at C0"
                break
            }
            if D0[i] != answer.1[i] {
                result = false
                message += "problem at D0"
                break
            }
        }
        XCTAssertTrue(result, message)
    }
    let keyrotsLeftAdjusted = keyRot.map({$0 * -1})
    func testRotation() {
        // 1. given
        let c0:BitVector = BitVector(bits: C0)
        let c2:BitVector = BitVector(bits: C2)
        var result = true
        // 2. when
        let c1 = c0.rotated(by: keyrotsLeftAdjusted[0])
        let c3 = c2.rotated(by: keyrotsLeftAdjusted[2])
        // 3. then
        for i in 0..<C1.count {
            if C1[i] != c1[i] {
                result = false
                break
            }
        }
        for i in 0..<C3.count {
            if C3[i] != c3[i] {
                result = false
                break
            }
        }
        XCTAssertTrue(result, "")
    }
}
