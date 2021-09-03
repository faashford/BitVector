import XCTest
@testable import BitVector

final class BitVectorInitTests: XCTestCase {
    /**
     Tests for equivalency between an initialized `BitVector` and its `[UInt8]` input
     */
    func testInitWithArrayOfBits() {
        // 1. given
        // Array of bits 64 bits long (MAsUInt8 which is a [UInt8]
        var countEqual = true
        var bitsEqual = true
        var diagnosticMessage = ""
        var bitMarker = 0
        // 2. when
        // the BitVector initializes without an issue
        let out = BitVector(bits: MAsUInt8)
        // 3. then
        // comparing the Array with the contents of the BitVector should be the same
        if MAsUInt8.count != out.count {
            countEqual = false
            diagnosticMessage += "- out.count is different from MAsUInt8.count by: \(out.count - MAsUInt8.count)"
        }
        // comparing the length of the BitVector and Array should be the same
        for i in 0..<MAsUInt8.count {
            if MAsUInt8[i] != out[i] {
                bitsEqual = false
                bitMarker = i
                diagnosticMessage += "\n- Bits do not match. Difference occurs at bit \(bitMarker)"
            }
        }
        XCTAssertTrue(countEqual && bitsEqual, diagnosticMessage)
    }
    /**
     Tests for equivalency between an initialized `BitVector` and its `String` input
     */
    func testInitWithStringOfBits() {
        // 1. given
        // A string of ones and zeros (a_hAsBitString), of count 64
        var countEqual = true
        var bitsEqual = true
        var diagnosticMessage = ""
        var bitMarker = 0
        // 2. when
        // the BitVector initializes without an issue
        let out = BitVector(bits: a_hAsBitStringNoSpaces)
        // 3. then
        // the count of a_hAsBitString should equal the count of out
        if a_hAsBitStringNoSpaces.count != out.count {
            countEqual = false
            diagnosticMessage += "- out.count is different from a_hAsBitString.count by: \(out.count - a_hAsBitStringNoSpaces.count)"
        }
        // the bits in a_hAsBitString should equal those in out
        for (i,bit) in a_hAsBitStringNoSpaces.enumerated() {
            if CFBit(String(bit)) != out[i] {
                bitsEqual = false
                bitMarker = i
                diagnosticMessage += "\n- Bits do not match. Difference occurs at bit \(bitMarker)"
            }
        }
        XCTAssertTrue(countEqual && bitsEqual, diagnosticMessage)
    }
    func testInitWithSliceOfABitVector() {
        // 1. given a bit vector
        let m = "00001011"
        let m_prime = "11111011"
        var testBV = BitVector(bits: m)
        var bitsEqual = true
        var countEqual = true
        var bitMarker = 0
        var diagnosticMessage = ""
        // 2. when a segment of the BitVector is returned as a Slice
        // that slice can be used to initialize a new BitVector; in this case, the first
        // for bits change from 0000 to 1111. The length remains the same.
        testBV.replaceSubrange(0...3, with: repeatElement(1, count: 4))
        // 3. then bits and count in the new bit vector should match the portion
        // extracted to make the Slice
        if m.count != testBV.count {
            countEqual = false
            diagnosticMessage += "- out.count is different from m_prime.count by: \(m.count - testBV.count)"
        }
        for (i, bit) in m_prime.enumerated() {
            if CFBit(String(bit)) != testBV[i] {
                bitsEqual = false
                bitMarker = i
                diagnosticMessage += "\n - Bits do not match. Difference occurs at bit \(bitMarker)"
                XCTAssertTrue(true == countEqual && true == bitsEqual, diagnosticMessage)
            }
        }
        XCTAssertTrue(true == countEqual && true == bitsEqual, diagnosticMessage)
    }   }

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
//
//final class TestBitVectorSpecificOperations : XCTestCase {
//    func testPermutedVector() {
//        // 1. given
//        let testBV: BitVector = BitVector(bits: M)
//        let pv = IP.map({$0 - 1})
//        var result = true
//        var message = ""
//        // 2. when
//        let permuted = testBV.permuted(with: pv)
//        // 3. then
//        if pv.count != permuted.count {
//            result = false
//            message += "failed to count properly, "
//        }
//        for i in 0..<permuted.count {
//            if M_permutedByIP[i] != permuted[i] {
//                result = false
//                message += "bits don't match"
//                break
//            }
//        }
//        XCTAssertTrue(result, message)
//    }
//    func testPermutedCount() {
//        // 1. given
//        let testBV: BitVector = BitVector(bits: M)
//        let pv = IP.map({$0 - 1})
//        var result = true
//        // 2. when
//        let permuted = testBV.permuted(with: pv)
//        // 3. then
//        if pv.count != permuted.count {
//            result = false
//        }
//        XCTAssertTrue(result)
//    }
//    func testHalved() {
//        // 1. given
//        let testBV:BitVector = BitVector(bits: K_plus)
//        var result = true
//        var message = ""
//        // 2. when
//        let answer = testBV.halved()
//        // 3. then
//        for i in 0..<C0.count {
//            if C0[i] != answer.0[i] {
//                result = false
//                message += "problem at C0"
//                break
//            }
//            if D0[i] != answer.1[i] {
//                result = false
//                message += "problem at D0"
//                break
//            }
//        }
//        XCTAssertTrue(result, message)
//    }
//    let keyrotsLeftAdjusted = keyRot.map({$0 * -1})
//    func testRotation() {
//        // 1. given
//        let c0:BitVector = BitVector(bits: C0)
//        let c2:BitVector = BitVector(bits: C2)
//        var result = true
//        // 2. when
//        let c1 = c0.rotated(by: keyrotsLeftAdjusted[0])
//        let c3 = c2.rotated(by: keyrotsLeftAdjusted[2])
//        // 3. then
//        for i in 0..<C1.count {
//            if C1[i] != c1[i] {
//                result = false
//                break
//            }
//        }
//        for i in 0..<C3.count {
//            if C3[i] != c3[i] {
//                result = false
//                break
//            }
//        }
//        XCTAssertTrue(result, "")
//    }
//}
//            func testInitWithStringNotNil() {
//                // 1. given
//                // K
//                let testBV:BitVector
//                // 2. when
//                testBV = BitVector(block: K)
//                // 3. then
//                XCTAssertNotNil(testBV)
//            }
//            func testInitWithStringBitsOK() {
//                // 1. given
//                // K
//                let testBV:BitVector
//                var result = true
//                // 2. when
//                testBV = BitVector(block: K)
//                // 3. then
//                for i in 0..<64 {
//                    let answer = KAsUInt8[i]
//                    let value = CFBitVectorGetBitAtIndex(testBV.bv,i)
//                    if answer != value {
//                        result = false
//                        break
//                    }
//                }
//                XCTAssertTrue(result)
//            }
//        }
//        final class BitVectorPrintingTests: XCTestCase {
//            // bitsToString(bv: BitVector) -> String
//            func testGetString() {
//                // 1. given a_h as a string
//                var stringMatches = true
//                var testBV:BitVector
//                // 2. when
//                testBV = BitVector(block: a_h)
//                // 3. then
//                if a_h != testBV.getString() {
//                    stringMatches = false
//                }
//                XCTAssertTrue(stringMatches)
//            }
//            func testGetBits() {
//                // 1. given
//                // a_h as a string
//                // a_h as bits as a [UInt8]
//                var stringMatches = true
//                var testBV:BitVector
//                // 2. when
//                testBV = BitVector(block: a_h)
//                // 3. then
//                if a_hAsBitString != testBV.getBits() {
//                    stringMatches = false
//                }
//                XCTAssert(stringMatches)
//            }
//        }
//        final class DESSpecificMethodsTests: XCTestCase {
//            func testRotated() {
//                // 1. given
//                var result = true
//                // keyRot: the rotation vector
//                var c0:BitVector
//                var c2:BitVector
//                // 2. when
//                // c0 and c2 are initialized as:
//                c0 = BitVector(bits: C0)
//                c2 = BitVector(bits: C2)
//                // and then they are rotated as perscribed by keyRot:
//                let c1 = c0.rotated(by: -1 * keyRot[0])
//                let c3 = c2.rotated(by: -1 * keyRot[2])
//                // 3. then
//                // derived `c1` should be the same as static `C1` and so on
//                for i in 0..<28 {
//                    if C1[i] != c1[i] || C3[i] != c3[i] {
//                        result = false
//                        break
//                    }
//                }
//                XCTAssertTrue(result)
//            }
//        }
//
//        final class AggregateTests : XCTestCase {
//            func testArrayInitialization() {
//                // 1. given
//                // M an 8 character message
//                var testBVs = [BitVector]()
//                let sampleBV = BitVector(block: M)
//                var result = true
//                var message = ""
//                // 2. when
//                for _ in 0..<17 {
//                    testBVs.append(sampleBV)
//                }
//                // 3. then
//                if 17 != testBVs.count {
//                    result = false
//                    message = "**** Fail: testBVs.count is actually \(testBVs.count)."
//                } else {
//                    message = "Success"
//                }
//                XCTAssertTrue(result, message)
//            }
//            func testArrayTuplesInitialization() {
//                // 1. given
//                // M and K are 8 character strings
//                let leftSampleBV = BitVector(block: M)
//                let rightSampleBV = BitVector(block: K)
//                var testTuple = [(BitVector, BitVector)]()
//                var result = true
//                var message = ""
//                // 2. when
//                // the tuples are set with left and right samples, 17 times using append()
//                for _ in 0..<17 {
//                    testTuple.append((leftSampleBV,rightSampleBV))
//                }
//                // 3. then
//                // the length of the array of tuples should be 17
//                if 17 != testTuple.count {
//                    result = false
//                    message = "**** Fail: testTuple.count is actually \(testTuple.count)."
//                } else {
//                    message = "Success"
//                }
//                XCTAssertTrue(result, message)
//            }
//        }
//
//    func testDefaultInitNotNil() {
//        // 1. given
//        let testBV:BitVector
//        // 2. when
//        testBV = BitVector()
//        // 3. then
//        XCTAssertNotNil(testBV)
//    }
//    func testDefaultInitCountIs64() {
//        // 1. given
//        var result = true
//        let testBV:BitVector
//        let defaultBitVectorLength = 64
//        // 2. when
//        testBV = BitVector()
//        // 3. then
//        if defaultBitVectorLength != CFBitVectorGetCount(testBV.bv) && defaultBitVectorLength != testBV.getCount() {
//            result = false
//        }
//        XCTAssertTrue(result)
//    }
//    func testUInt8InitNotNil() {
//        // 1. given
//        let testBV:BitVector
//        // 2. when
//        testBV = BitVector(bits: M)
//        // 3. then
//        XCTAssertNotNil(testBV)
//    }
//    func testUInt8InitCountIs64() {
//        // 1. given
//        let testBV:BitVector
//        var result = true
//        let defaultBitVectorLength = 64
//        // 2. when
//        testBV = BitVector(bits: M)
//        // 3. then && defaultBitVectorLength != testBV.count
//        if defaultBitVectorLength != CFBitVectorGetCount(testBV.bv) && defaultBitVectorLength != testBV.getCount() {
//            result = false
//        }
//        XCTAssertTrue(result)
//    }
//}
//
//final class BitVectorBitGetSetTests: XCTestCase {
//    func testSetGet() {
//        // 1. given
//        // M is an existing test vector
//        let testBV:BitVector
//        let defaultBitVectorLength = 64
//        var result = true
//        // 2. when
//        testBV = BitVector(size: defaultBitVectorLength)
//        for index in 0..<defaultBitVectorLength {
//            testBV.setBit(index: index, value: CFBit(M[index]))
//        }
//        // 3. then
//        for index in 0..<defaultBitVectorLength {
//            if M[index] != testBV.getBit(index: index) {
//                result = false
//            }
//        }
//        XCTAssertTrue(result)
//    }
//    func testGetData() {
//        // 1. given
//        // M is an existing test array
//        var result = true
//        let testBV:BitVector
//        // 2. when
//        testBV = BitVector(bits: M)
//        // 3. then
//        let x = testBV.getData()
//        for index in 0..<64 {
//            if x.bits[index] != M[index] {
//                result = false
//                break
//            }
//        }
//        XCTAssertTrue(result)
//    }
//}
//
//final class BitVectorSequenceProtocolTests: XCTestCase {
//    func testSequenceIteration () {
//        // 1. given
//        var testBV: BitVector
//        var result = true
//        // 2. when
//        testBV = BitVector(bits: M)
//        // 3. then
//        for (i, bit) in testBV.enumerated() {
//            if M[i] != bit {
//                result = false
//                break
//            }
//        }
//        XCTAssertTrue(result)
//    }
//    func testPrefix() {
//        // 1. given
//        var testBV: BitVector
//        var result = true
//        // 2. when
//        testBV = BitVector(bits: M)
//        let prefix16 = testBV.prefix(16)
//        // 3. then
//        for i in 0..<16 {
//            if M[i] != prefix16[i] {
//                result = false
//                break
//            }
//        }
//        XCTAssertTrue(result)
//    }
//
//}
//
//final class RangeReplaceableCollectionProtocolTests: XCTestCase {
//    func testAppendOperator() {
//        // 1. given
//        let testBV1:BitVector = BitVector(bits: M)
//        let testBV2:BitVector = BitVector(bits: K)
//        let testBV3:BitVector = BitVector(bits: K_plus)
//        var result = true
//        var message = ""
//        // 2. when
//        let out = testBV1 + testBV2 + testBV3
//        // 3. then
//        for i in 0..<(testBV1.count+testBV2.count+testBV3.count) {
//            if testBV1[i] != out[i] {
//                result = false
//                message = "testBV1 comparison failed"
//                break
//            }
//            if testBV2[i] != out[i+testBV1.count] {
//                result = false
//                message = "testBV2 comparison failed"
//                break
//            }
//            if testBV3[i] != out[i+testBV1.count+testBV2.count] {
//                result = false
//                message = "testBV3 comparison failed"
//                break
//            }
//        }
//        XCTAssertTrue(result, message)
//    }
//
//}
//
//final class BitVectorCollectionProtocolTests : XCTestCase {
//    func testSubscriptIteration() {
//        // 1. given
//        var testBV: BitVector
//        var result = true
//        // 2. when
//        testBV = BitVector(bits: M)
//        // 3. then
//        for (i, bit) in testBV.enumerated() {
//            if M[i] != bit {
//                result = false
//                break
//            }
//        }
//        XCTAssertTrue(result)
//    }
//    func testCount() {
//        // 1. given
//        var testBV: BitVector
//        var result = true
//        // 2. when
//        testBV = BitVector(bits: M)
//        // 3. then
//        if 64 != testBV.count {
//            result = false
//        }
//        XCTAssertTrue(result)
//    }
//}
//
