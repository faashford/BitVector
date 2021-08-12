# BitVector

Type for managing sets of bits of arbitrary size.

## What is supported?

`CFMutableBitVector` is a core foundation type. As such it does not have very "Swifty" behavior. This library remedies that to some extent.

`BitVector` wraps `CFMutableBitVector` type such that the following are supported:

- `Sequence`, `Collection`, `RangeReplaceableCollection` and `BitwiseOperations` protocols
- Dividing a bit vector in two
- Joining two or more bit vectors into one
- Permuting (rearranging bit vector bits according to a formula)
- Rotating

### Why develop this library?

Motivation for creating this type was to support a DES implementation without using an array or using the bits of an integer. It was thought using the `CFMutableBitVector` type would use less memory than an array. The type used when storing bits into a `CFMutableBitVector` and the type when retrieving bits from same is a type `CFBit`. It was thought this somehow represented a single bit. However, `CFBit` is an integer, likely making any efficiencies gained over an array non-existent. 

## Release Notes

### v1.0.0

Is the first complete implementation. It is being used to develop a DES implementation.

 
 
