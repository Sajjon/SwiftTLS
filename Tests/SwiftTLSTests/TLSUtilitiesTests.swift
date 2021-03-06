//
//  TLSUtilitiesTests.swift
//  SwiftTLS
//
//  Created by Nico Schmidt on 14.04.15.
//  Copyright (c) 2015 Nico Schmidt. All rights reserved.
//

import XCTest
@testable import SwiftTLS

class TLSUtilitiesTests: XCTestCase {
    static var allTests = [
        ("test_SHA1_withKnownValues_givesCorrectResult", test_SHA1_withKnownValues_givesCorrectResult),
        ("test_P_SHA1_withKnownValues_givesCorrectResult", test_P_SHA1_withKnownValues_givesCorrectResult),
        ("test_P_SHA256_withKnownValues_givesCorrectResult", test_P_SHA256_withKnownValues_givesCorrectResult),
    ]

    func test_SHA1_withKnownValues_givesCorrectResult()
    {
        let hash = Hash_SHA1([UInt8]("abc".utf8))
        let expectedResult : [UInt8] = [0xa9, 0x99, 0x3e, 0x36, 0x47, 0x06, 0x81, 0x6a, 0xba, 0x3e, 0x25, 0x71, 0x78, 0x50, 0xc2, 0x6c, 0x9c, 0xd0, 0xd8, 0x9d]
        
        XCTAssertEqual(hash, expectedResult)
    }
    
    
    
    func test_P_SHA1_withKnownValues_givesCorrectResult()
    {
        let secret          : [UInt8] = [25, 46, 104, 149, 87, 175, 96, 194, 56, 189, 109, 67, 127, 254, 197, 82, 145, 220, 36, 154, 41, 78, 204, 233, 234, 202, 29, 148, 174, 63, 172, 255]
        let seed            : [UInt8] = [46, 97, 125, 50, 55, 253, 149, 131, 26, 245, 137, 49, 100, 56, 218, 68, 87, 186, 136, 192, 31, 69, 226, 163, 206, 18, 199, 15, 29, 251, 234, 48]
        let expectedResult  : [UInt8] = [100, 195, 143, 212, 209, 90, 229, 82, 147, 67, 194, 54, 107, 1, 151, 14, 60, 202, 63, 238, 188, 233, 235, 163, 137, 169, 224, 2, 7, 249, 55, 228]
        

        let hash = P_hash(HMAC_SHA1, secret: secret, seed: seed, outputLength: 32)
        
        XCTAssertEqual(hash, expectedResult)
    }
    
    
    
    func test_P_SHA256_withKnownValues_givesCorrectResult()
    {
        let secret          : [UInt8] = [0x9b, 0xbe, 0x43, 0x6b, 0xa9, 0x40, 0xf0, 0x17, 0xb1, 0x76, 0x52, 0x84, 0x9a, 0x71, 0xdb, 0x35]
        let seed            : [UInt8] = [0xa0, 0xba, 0x9f, 0x93, 0x6c, 0xda, 0x31, 0x18, 0x27, 0xa6, 0xf7, 0x96, 0xff, 0xd5, 0x19, 0x8c]
        let label           : [UInt8] = [0x74, 0x65, 0x73, 0x74, 0x20, 0x6c, 0x61, 0x62, 0x65, 0x6c]
        let expectedResult  : [UInt8] = [
            0xe3, 0xf2, 0x29, 0xba, 0x72, 0x7b, 0xe1, 0x7b,
            0x8d, 0x12, 0x26, 0x20, 0x55, 0x7c, 0xd4, 0x53,
            0xc2, 0xaa, 0xb2, 0x1d, 0x07, 0xc3, 0xd4, 0x95,
            0x32, 0x9b, 0x52, 0xd4, 0xe6, 0x1e, 0xdb, 0x5a,
            0x6b, 0x30, 0x17, 0x91, 0xe9, 0x0d, 0x35, 0xc9,
            0xc9, 0xa4, 0x6b, 0x4e, 0x14, 0xba, 0xf9, 0xaf,
            0x0f, 0xa0, 0x22, 0xf7, 0x07, 0x7d, 0xef, 0x17,
            0xab, 0xfd, 0x37, 0x97, 0xc0, 0x56, 0x4b, 0xab,
            0x4f, 0xbc, 0x91, 0x66, 0x6e, 0x9d, 0xef, 0x9b,
            0x97, 0xfc, 0xe3, 0x4f, 0x79, 0x67, 0x89, 0xba,
            0xa4, 0x80, 0x82, 0xd1, 0x22, 0xee, 0x42, 0xc5,
            0xa7, 0x2e, 0x5a, 0x51, 0x10, 0xff, 0xf7, 0x01,
            0x87, 0x34, 0x7b, 0x66
        ]
        
        let hash = P_hash(HMAC_SHA256, secret: secret, seed: label + seed, outputLength: 100)
        
        XCTAssertEqual(hash, expectedResult)
    }

    
    
}
