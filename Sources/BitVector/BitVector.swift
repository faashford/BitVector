//
//  BitVector.swift
//
//
//  Created by Francis Alan Ashford on 8/4/21.
//

import Foundation

struct BitVector : CustomStringConvertible {
    var bv: CFMutableBitVector?
    var count: Int
    init() {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, 64)
        CFBitVectorSetCount(bv, 64)
        count = 64
    }
    init(size: Int) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, size)
        CFBitVectorSetCount(bv, size)
        count = size
    }
    init(_ bits: [UInt8]) {
        bv = CFBitVectorCreateMutable(kCFAllocatorDefault, 0)
        CFBitVectorSetCount(bv, bits.count)
        count = bits.count
        for (i,bit) in bits.enumerated() {
            CFBitVectorSetBitAtIndex(bv, CFIndex(i), CFBit(bit))
        }
    }
    func getBit(index: CFIndex) -> CFBit {
        assert (count > index && 0 <= index)
        return CFBitVectorGetBitAtIndex(bv, index)
    }
    func setBit(index: CFIndex, value: CFBit) {
        assert (count > index && 0 <= index)
        CFBitVectorSetBitAtIndex(bv, index, value)
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
    func makeIterator() -> BitVectorIterator {
        return BitVectorIterator(self)
    }
}
struct BitVectorIterator : IteratorProtocol {
    var bv: BitVector
    var index:CFIndex = 0
    
    init(_ bv: BitVector) {
        self.bv = bv
    }
    mutating func next() -> CFBit? {
        guard bv.count > index else { return nil }
        let bit:CFBit = CFBitVectorGetBitAtIndex(bv.bv, index)
        index += 1
        return bit
    }
}

extension BitVector : Collection {
    func index(after i: Int) -> Int {
        return i + 1
    }
    var startIndex: CFIndex {
        return 0
    }
    var endIndex: CFIndex {
        return CFBitVectorGetCount(bv)
    }
    subscript(position: CFIndex) -> CFBit {
        get { return CFBitVectorGetBitAtIndex(bv, position) }
        set { CFBitVectorSetBitAtIndex(bv, position, newValue) }
    }
}

extension BitVector : RangeReplaceableCollection {
    
    mutating func replaceSubrange<C>(_ subrange: Range<Self.Index>, with newElements: C) where C : Collection, Self.Element == C.Element {
        
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
