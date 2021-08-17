//
//  TestConstants.swift
//  
//
//  Created by Francis Alan Ashford on 8/4/21.
//

import Foundation

var greeting = "Hello, playground"

// useful constants for bitwise operator testing

let bitwiseOpsConstant05:[UInt8] = [0,0,0,0,0,1,0,1]
let bitwiseOpsConstant00:[UInt8] = [0,0,0,0,0,0,0,0]

let a_h = "abcdefgh"
let a_hBits = [0,1,1,0,0,0,0,1, 0,1,1,0,0,0,1,0, 0,1,1,0,0,0,1,1, 0,1,1,0,0,1,0,0, 0,1,1,0,0,1,0,1, 0,1,1,0,0,1,1,0, 0,1,1,0,0,1,1,1, 0,1,1,0,1,0,0,0]

// related to M
let M:[UInt8] = [0,0,0,0, 0,0,0,1, 0,0,1,0, 0,0,1,1, 0,1,0,0, 0,1,0,1, 0,1,1,0, 0,1,1,1, 1,0,0,0, 1,0,0,1, 1,0,1,0, 1,0,1,1, 1,1,0,0, 1,1,0,1, 1,1,1,0, 1,1,1,1]
let IP:[Int] = [58,   50,  42,   34,   26,  18,   10,   2,
                60,   52,  44,   36,   28,  20,   12,   4,
                62,   54,  46,   38,   30,  22,   14,   6,
                64,   56,  48,   40,   32,  24,   16,   8,
                57,   49,  41,   33,   25,  17,    9,   1,
                59,   51,  43,   35,   27,  19,   11,   3,
                61,   53,  45,   37,   29,  21,   13,   5,
                63,   55,  47,   39,   31,  23,   15,   7]
let M_permutedByIP:[UInt8] = [1,1,0,0, 1,1,0,0, 0,0,0,0, 0,0,0,0, 1,1,0,0, 1,1,0,0, 1,1,1,1, 1,1,1,1, 1,1,1,1, 0,0,0,0, 1,0,1,0, 1,0,1,0, 1,1,1,1, 0,0,0,0, 1,0,1,0, 1,0,1,0]
let L:[UInt8] = [0,0,0,0, 0,0,0,1, 0,0,1,0, 0,0,1,1, 0,1,0,0, 0,1,0,1, 0,1,1,0, 0,1,1,1]
let R:[UInt8] = [1,0,0,0, 1,0,0,1, 1,0,1,0, 1,0,1,1, 1,1,0,0, 1,1,0,1, 1,1,1,0, 1,1,1,1]
// Key
let K:[UInt8] = [0,0,0,1,0,0,1,1, 0,0,1,1,0,1,0,0, 0,1,0,1,0,1,1,1, 0,1,1,1,1,0,0,1, 1,0,0,1,1,0,1,1, 1,0,1,1,1,1,0,0, 1,1,0,1,1,1,1,1, 1,1,1,1,0,0,0,1]
let K_plus:[UInt8] = [1,1,1,1,0,0,0, 0,1,1,0,0,1,1, 0,0,1,0,1,0,1, 0,1,0,1,1,1,1, 0,1,0,1,0,1,0, 1,0,1,1,0,0,1, 1,0,0,1,1,1,1, 0,0,0,1,1,1,1]

let keyRot:[Int] = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]

let PC_1:[Int] = [57,   49,    41,   33,    25,    17,    9,
                     1,   58,    50,   42,    34,    26,   18,
                    10,    2,    59,   51,    43,    35,   27,
                    19,   11,     3,   60,    52,    44,   36,
                    63,   55,    47,   39,    31,    23,   15,
                     7,   62,    54,   46,    38,    30,   22,
                    14,    6,    61,   53,    45,    37,   29,
                    21,   13,     5,   28,    20,    12,    4]
let PC_2:[Int] = [14,   17,  11,   24,    1,   5,
                     3,   28,  15,    6,   21,  10,
                    23,   19,  12,    4,   26,   8,
                    16,    7,  27,   20,   13,   2,
                    41,   52,  31,   37,   47,  55,
                    30,   40,  51,   45,   33,  48,
                    44,   49,  39,   56,   34,  53,
                    46,   42,  50,   36,   29,  32]

let C0:[UInt8] = [1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1]
let D0:[UInt8] = [0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1]

let C1:[UInt8] = [1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1]
let D1:[UInt8] = [1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0]

let C2:[UInt8] = [1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1]
let D2:[UInt8] = [0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1]

let C3:[UInt8] = [0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1]
let D3:[UInt8] = [0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1]

let C4:[UInt8] = [0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0]
let D4:[UInt8] = [0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1]

let C5:[UInt8] = [1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0]
let D5:[UInt8] = [0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1]

let C6:[UInt8] = [0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1]
let D6:[UInt8] = [1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1]

let C7:[UInt8] = [1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0]
let D7:[UInt8] = [0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0]

let C8:[UInt8] = [0,0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,1]
let D8:[UInt8] = [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1]

let C9:[UInt8] = [0,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,1,0]
let D9:[UInt8] = [0,0,1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1]

let C10:[UInt8] = [0,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1]
let D10:[UInt8] = [1,1,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0]

let C11:[UInt8] = [0,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1]
let D11:[UInt8] = [1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1]

let C12:[UInt8] = [0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1]
let D12:[UInt8] = [0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1]

let C13:[UInt8] = [0,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1]
let D13:[UInt8] = [0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0]

let C14:[UInt8] = [1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1]
let D14:[UInt8] = [1,1,1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1]

let C15:[UInt8] = [1,1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1]
let D15:[UInt8] = [1,0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1]

let C16:[UInt8] = [1,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,1,0,1,0,1,0,1,0,1,1,1,1]
let D16:[UInt8] = [0,1,0,1,0,1,0,1,0,1,1,0,0,1,1,0,0,1,1,1,1,0,0,0,1,1,1,1]

let K1:[UInt8] = [0,0,0,1,1,0, 1,1,0,0,0,0, 0,0,1,0,1,1, 1,0,1,1,1,1, 1,1,1,1,1,1, 0,0,0,1,1,1, 0,0,0,0,0,1, 1,1,0,0,1,0]
let K2:[UInt8] = [0,1,1,1,1,0, 0,1,1,0,1,0, 1,1,1,0,1,1, 0,1,1,0,0,1, 1,1,0,1,1,0, 1,1,1,1,0,0, 1,0,0,1,1,1, 1,0,0,1,0,1]
let K3:[UInt8] = [0,1,0,1,0,1, 0,1,1,1,1,1, 1,1,0,0,1,0, 0,0,1,0,1,0, 0,1,0,0,0,0, 1,0,1,1,0,0, 1,1,1,1,1,0, 0,1,1,0,0,1]
let K4:[UInt8] = [0,1,1,1,0,0, 1,0,1,0,1,0, 1,1,0,1,1,1, 0,1,0,1,1,0, 1,1,0,1,1,0, 1,1,0,0,1,1, 0,1,0,1,0,0, 0,1,1,1,0,1]
let K5:[UInt8] = [0,1,1,1,1,1, 0,0,1,1,1,0, 1,1,0,0,0,0, 0,0,0,1,1,1, 1,1,1,0,1,0, 1,1,0,1,0,1, 0,0,1,1,1,0, 1,0,1,0,0,0]
let K6:[UInt8] = [0,1,1,0,0,0, 1,1,1,0,1,0, 0,1,0,1,0,0, 1,1,1,1,1,0, 0,1,0,1,0,0, 0,0,0,1,1,1, 1,0,1,1,0,0, 1,0,1,1,1,1]
let K7:[UInt8] = [1,1,1,0,1,1, 0,0,1,0,0,0, 0,1,0,0,1,0, 1,1,0,1,1,1, 1,1,1,1,0,1, 1,0,0,0,0,1, 1,0,0,0,1,0, 1,1,1,1,0,0]
let K8:[UInt8] = [1,1,1,1,0,1, 1,1,1,0,0,0, 1,0,1,0,0,0, 1,1,1,0,1,0, 1,1,0,0,0,0, 0,1,0,0,1,1, 1,0,1,1,1,1, 1,1,1,0,1,1]
let K9:[UInt8] = [1,1,1,0,0,0, 0,0,1,1,0,1, 1,0,1,1,1,1, 1,0,1,0,1,1, 1,1,1,0,1,1, 0,1,1,1,1,0, 0,1,1,1,1,0, 0,0,0,0,0,1]
let K10:[UInt8] = [1,0,1,1,0,0, 0,1,1,1,1,1, 0,0,1,1,0,1, 0,0,0,1,1,1, 1,0,1,1,1,0, 1,0,0,1,0,0, 0,1,1,0,0,1, 0,0,1,1,1,1]
let K11:[UInt8] = [0,0,1,0,0,0, 0,1,0,1,0,1, 1,1,1,1,1,1, 0,1,0,0,1,1, 1,1,0,1,1,1, 1,0,1,1,0,1, 0,0,1,1,1,0, 0,0,0,1,1,0]
let K12:[UInt8] = [0,1,1,1,0,1, 0,1,0,1,1,1, 0,0,0,1,1,1, 1,1,0,1,0,1, 1,0,0,1,0,1, 0,0,0,1,1,0, 0,1,1,1,1,1, 1,0,1,0,0,1]
let K13:[UInt8] = [1,0,0,1,0,1, 1,1,1,1,0,0, 0,1,0,1,1,1, 0,1,0,0,0,1, 1,1,1,1,1,0, 1,0,1,0,1,1, 1,0,1,0,0,1, 0,0,0,0,0,1]
let K14:[UInt8] = [0,1,0,1,1,1, 1,1,0,1,0,0, 0,0,1,1,1,0, 1,1,0,1,1,1, 1,1,1,1,0,0, 1,0,1,1,1,0, 0,1,1,1,0,0, 1,1,1,0,1,0]
let K15:[UInt8] = [1,0,1,1,1,1, 1,1,1,0,0,1, 0,0,0,1,1,0, 0,0,1,1,0,1, 0,0,1,1,1,1, 0,1,0,0,1,1, 1,1,1,1,0,0, 0,0,1,0,1,0]
let K16:[UInt8] = [1,1,0,0,1,0, 1,1,0,0,1,1, 1,1,0,1,1,0, 0,0,1,0,1,1, 0,0,0,0,1,1, 1,0,0,0,0,1, 0,1,1,1,1,1, 1,1,0,1,0,1]

let eBitSelectionTable:[Int] = [32,    1,   2,    3,    4,   5,
                                 4,    5,   6,    7,    8,   9,
                                 8,    9,  10,   11,   12,  13,
                                12,   13,  14,   15,   16,  17,
                                16,   17,  18,   19,   20,  21,
                                20,   21,  22,   23,   24,  25,
                                24,   25,  26,   27,   28,  29,
                                28,   29,  30,   31,   32,   1]
