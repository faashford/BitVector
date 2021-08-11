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
    // var count: CFIndex = 0
    public init() {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, desBlockSize)
        CFBitVectorSetCount(bv, desBlockSize)
        // count = desBlockSize
    }
    public init(size: Int = 64) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, size)
        CFBitVectorSetCount(bv, size)
        // count = size
    }
    public init(bits: [UInt8]) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, bits.count)
        CFBitVectorSetCount(bv, bits.count)
        // count = CFIndex(bits.count)
        for (i,bit) in bits.enumerated() {
            CFBitVectorSetBitAtIndex(bv, CFIndex(i), CFBit(bit))
        }
    }
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
    public var description: String {
        var allBits = ""
        
        for i in 0..<count {
            if (i % 8 == 0) && 0 != i {
                allBits += " "
            }
            allBits += String(CFBitVectorGetBitAtIndex(bv, i))
            
        }
        return(allBits)
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

extension BitVector {
    static func |(lhs: BitVector, rhs: BitVector) -> BitVector{
        assert(lhs.count == rhs.count)
        var out = BitVector(size: lhs.count)
        for i in 0..<lhs.count {
            out[i] = lhs[i] | rhs[i]
        }
        return out
    }
    static func ^(lhs: BitVector, rhs: BitVector) -> BitVector {
        assert(lhs.count == rhs.count)
        var out = BitVector(size: lhs.count)
        for i in 0..<lhs.count {
            out[i] = lhs[i] ^ rhs[i]
        }
        return out
    }
    static func &(lhs: BitVector, rhs: BitVector) -> BitVector {
        assert(lhs.count == rhs.count)
        var out = BitVector(size: lhs.count)
        for i in 0..<lhs.count {
            out[i] = lhs[i] & rhs[i]
        }
        return out
    }
    static prefix func ~(bv: BitVector) -> BitVector {
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

extension BitVector {
    public func permuted(with pv: [Int]) -> BitVector {
        let out = BitVector(size: pv.count)
        for i in 0..<pv.count {
            CFBitVectorSetBitAtIndex(out.bv, i, CFBitVectorGetBitAtIndex(self.bv, pv[i]))
        }
        return out
    }
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
    func rotated(by r: Int) -> BitVector {
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
