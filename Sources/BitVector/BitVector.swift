//
//  BitVector.swift
//
//
//  Created by Francis Alan Ashford on 8/4/21.
//
import Foundation

let desBlockSize = 64

public struct BitVector : CustomStringConvertible {
    var bv: CFMutableBitVector?

    /**
     `init(block s: String)` initializes a BitVector based on a string of characters.
     
     This is the primary method used to initialize bit vectors. The length of the string argument must be 8 characters.
     
     This initialization method initializes a BitVector one character at a time. The number of the character is broken down to bits. The bits are stored in the BitVector in Big-endian order.
     
     - Parameter s: `String` eight characters long
     
     - Bug: `BitVectors` of size other than 8 characters are needed when calculating the sub-keys in the DES algorithm.
     */

    public init(block s: String) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, desBlockSize)
        CFBitVectorSetCount(bv, desBlockSize)
        let sAsArray = Array(s.utf16)
        // each of the 8 characters in s will generate 8 bits
        for sIndex in 0..<sAsArray.count {
            for (i,charOffset) in stride(from: UInt8.bitWidth - 1, through: 0, by: -1).enumerated() {
                CFBitVectorSetBitAtIndex(bv, i+(UInt8.bitWidth*sIndex), UInt32(sAsArray[sIndex]) & 1 << charOffset)
            }
        }
    }
    /**
     Initializes a BitVector 64 bits long.
     
     This initialization is used by the RangeReplaceableCollection protocol. It is not used in the DES algorithm implementation.
     */
    public init() {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, desBlockSize)
        CFBitVectorSetCount(bv, desBlockSize)
    }
    /**
     Initializes a BitVector of arbitrary length.
     
     Used when initialization is needed prior to value assignment as when an aggregate of BitVectors is being set up.
     */
    public init(size: Int = 64) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, size)
        CFBitVectorSetCount(bv, size)
    }
    /**
     Initializes a BitVector based on an array of `[UInt8]`s.
     
     This is used when testing the BitVector. Bits are easier to compare when there is a problem.
     
     - Parameter bits: `[UInt8]` of arbitrary length.
     */
    public init(bits: [UInt8]) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, bits.count)
        CFBitVectorSetCount(bv, bits.count)
        for (i,bit) in bits.enumerated() {
            CFBitVectorSetBitAtIndex(bv, CFIndex(i), CFBit(bit))
        }
    }
    /**
     Initializes a BitVector from a `Slice` of a BitVector
     
     Returns from using any of the methods from the RangeReplaceableCollection will be Slices of the type. These slices must be converted to BitVector type in order to be useful: BitVector is not a generic.
     
     - Parameter slice: `Slice<BitVector>`, the typical return value from RangeReplaceableCollection functions.
     */
    init(slice: Slice<BitVector>) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, 0)
        CFBitVectorSetCount(bv, slice.count)
        var i = 0
        for bit in slice {
            CFBitVectorSetBitAtIndex(bv, i, bit)
            i += 1
        }
    }
    public func getBit(index: CFIndex) -> CFBit {
        assert (getCount() > index && 0 <= index)
        return CFBitVectorGetBitAtIndex(bv, index)
    }
    public func setBit(index: CFIndex, value: CFBit) {
        assert (getCount() > index && 0 <= index)
        CFBitVectorSetBitAtIndex(bv, index, value)
    }
    public func getCount() -> CFIndex {
        return CFBitVectorGetCount(self.bv)
    }
    public func getData() -> (count: Int, bits: [UInt8]){
        let count = Int(CFBitVectorGetCount(self.bv))
        var bits:[UInt8] = Array(repeating: 0, count: count)
        for index in 0..<count {
            bits[index] = UInt8(CFBitVectorGetBitAtIndex(self.bv, index))
        }
        return (count, bits)
    }
    public func bitsToString() -> String {
        var u = ""
        for i in stride(from: 0, to:self.count, by: 8) {
            let r = i..<8+i
            let t = self[r].reversed()
            var out = 0
            for offset in 0..<8 {
                out += Int(t[offset]) << offset
            }
            let f = String(Unicode.Scalar(out)!)
            u.append(f)
        }
        return u
    }
    public func getBits() -> String {
        var u = ""
        for (i,b) in self.enumerated() {
            if i % 8 == 0 && 0 != i {
                u.append(" ")
            }
            u.append(String(b))
        }
        return u
    }
    func getString() -> String {
        var u = ""
        for i in stride(from: 0, to: self.count, by: 8) {
            let r = i..<8+i
            let t = (self[r].reversed())
            var out = 0
            for offset in 0..<8 {
                out += Int(t[offset]) << offset
            }
            let f = String(Unicode.Scalar(out)!)
            u += f
        }
        return u
    }
    public var description: String {
        var out = self.getString() + "\n"
        out += self.getBits()
        return(out)
    }
}
extension BitVector : Sequence {
    public func makeIterator() -> BitVectorIterator {
        return BitVectorIterator(self)
    }
}
public struct BitVectorIterator : IteratorProtocol {
    var bv: BitVector
    var index:CFIndex = 0
    
    init(_ bv: BitVector) {
        self.bv = bv
    }
    public mutating func next() -> CFBit? {
        guard bv.getCount() > index else { return nil }
        let bit:CFBit = CFBitVectorGetBitAtIndex(bv.bv, index)
        index += 1
        return bit
    }
}

extension BitVector : Collection {
    public func index(after i: Int) -> Int {
        return i + 1
    }
    public var startIndex: CFIndex {
        return 0
    }
    public var endIndex: CFIndex {
        return CFBitVectorGetCount(bv)
    }
    public subscript(position: CFIndex) -> CFBit {
        get { return CFBitVectorGetBitAtIndex(bv, position) }
        set { CFBitVectorSetBitAtIndex(bv, position, newValue) }
    }
}

extension BitVector : RangeReplaceableCollection {
    
    mutating public func replaceSubrange<C>(_ subrange: Range<Self.Index>, with newElements: C) where C : Collection, Self.Element == C.Element {
        
        var bvStart = BitVector(size: subrange.lowerBound - self.startIndex)
        var bvEnd = BitVector(size: self.endIndex - subrange.upperBound)
        for bitIndex in self.startIndex..<subrange.lowerBound {
            bvStart[bitIndex] = self[bitIndex]
        }
        for (bvEndIndex, selfIndex) in (subrange.upperBound..<self.endIndex).enumerated() {
            bvEnd[bvEndIndex] = self[selfIndex]
        }
        var result = BitVector(size: bvStart.count + bvEnd.count + newElements.count)
        
        var resultIndex = 0
        for bit in bvStart {
            result[resultIndex] = bit
            resultIndex += 1
        }
        for bit in newElements {
            result[resultIndex] = bit
            resultIndex += 1
        }
        for bit in bvEnd {
            result[resultIndex] = bit
            resultIndex += 1
        }
        
        
        self = result
    }
}

/// Supports the BitwiseOperations protocol (dropped in Swift 3 somewhere)
extension BitVector {
    public static func |(lhs: BitVector, rhs: BitVector) -> BitVector{
        assert(lhs.count == rhs.count)
        var out = BitVector(size: lhs.count)
        for i in 0..<lhs.count {
            out[i] = lhs[i] | rhs[i]
        }
        return out
    }
    public static func ^(lhs: BitVector, rhs: BitVector) -> BitVector {
        assert(lhs.count == rhs.count)
        var out = BitVector(size: lhs.count)
        for i in 0..<lhs.count {
            out[i] = lhs[i] ^ rhs[i]
        }
        return out
    }
    public static func &(lhs: BitVector, rhs: BitVector) -> BitVector {
        assert(lhs.count == rhs.count)
        var out = BitVector(size: lhs.count)
        for i in 0..<lhs.count {
            out[i] = lhs[i] & rhs[i]
        }
        return out
    }
    public static prefix func ~(bv: BitVector) -> BitVector {
        var out = BitVector(size: bv.count)
        for i in 0..<bv.count {
            if 1 == bv[i] {
                out[i] = 0
            } else {
                out[i] = 1
            }
        }
        return out
    }
}

/// Methods supporting DES specifically
extension BitVector {
    /**
     Permute a `BitVector`.
     
     Uses a zero adjusted vector of index values (a permutation vector) to rearrange bits in a bit vector. For a permutation vector `pv`:
     ```
     pv = [7,5,1,0,3,6,4,2]
     ```
     operating on a `BitVector` `myBV`:
     ```
     myBV = [0,1,0,0,1,0,0,1]
     ```
     `permute()` places bit 0 of `myPV` into position 7, bit 1 into position 5 and so on:
     ```
     myPermutedBV = [0,0,1,0,0,1,0,1]
     ```

     Permutation can return a larger or smaller bit vector depending on the permutation vector.
     
     - Parameter pv: permutation vector; instructions for rearranging the `BitVector`.
     
     - Returns a `BitVector` of length `pv.count`.
     
     */
    public func permuted(with pv: [Int]) -> BitVector {
        let out = BitVector(size: pv.count)
        for i in 0..<pv.count {
            CFBitVectorSetBitAtIndex(out.bv, i, CFBitVectorGetBitAtIndex(self.bv, pv[i]))
        }
        return out
    }
    /**
     Split a `BitVector` into two equal halves.
     
     Create two new `BitVector`s of equal size from the caller where one `BitVector` is the first half and the other `BitVector` is the second half of the calling `BitVector`.
     
     - Returns: tuple of the left and right `BitVector`s resulting from the split.
     */
    public func halved() -> (BitVector, BitVector) {
        let l = BitVector(size: self.count/2)
        let r = BitVector(size: self.count/2)

        var selfIndex = 0

        for lIndex in 0..<self.count/2 {
            CFBitVectorSetBitAtIndex(l.bv, lIndex, CFBitVectorGetBitAtIndex(self.bv, selfIndex))
            selfIndex += 1
        }
        for rIndex in 0..<self.count/2 {
            CFBitVectorSetBitAtIndex(r.bv, rIndex, CFBitVectorGetBitAtIndex(self.bv, selfIndex))
            selfIndex += 1
        }

        return(l,r)
    }
    /**
     Creates a `BitVector` rotated by a specified amount.
     ```
     let testBV:BitVector(bits: [0,1,0,0,1,1,1,0]
     let rotatedBV = testBV.rotated(by: -2)
     ```
     then, `rotatedBV` is `[0,0,1,1,1,0,0,1]`.
     
     - Parameter r: Amount to rotate the `BitVector`.  Negative numbers rotate left.
     - Returns: `BitVector` rotated by `r`
     */
    public func rotated(by r: Int) -> BitVector {
        if (0 < r) {
            return self.rightRotated(by: r)
        } else {
            return self.leftRotated(by: abs(r))
        }
    }
    func leftRotated(by r: Int)  -> BitVector {
        let slice0 = BitVector(slice: self[self.startIndex..<r])
        let slice1 = BitVector(slice: self[r..<self.endIndex])
        return slice1 + slice0
    }
    func rightRotated(by r: Int) -> BitVector {
        let slice0 = BitVector(slice: self[self.startIndex..<self.endIndex - r])
        let slice1 = BitVector(slice: self[self.endIndex - r..<self.endIndex])
        return slice1 + slice0
    }
}
