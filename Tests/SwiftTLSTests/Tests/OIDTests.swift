//
//  OIDTests.swift
//  SwiftTLS
//
//  Created by Nico Schmidt on 10.01.16.
//  Copyright © 2016 Nico Schmidt. All rights reserved.
//

import XCTest
@testable import SwiftTLS

class OIDTests: XCTestCase {
    static var allTests = [
        ("test_identifier_withSomeTestVectors_givesCorrectResult", test_identifier_withSomeTestVectors_givesCorrectResult),
    ]

    func test_identifier_withSomeTestVectors_givesCorrectResult()
    {
        let values : [OID] = [
            .sha1
        ]
        
        for oid in values
        {
            let identifier = oid.identifier
            if let oid2 = OID(id: identifier) {
                XCTAssert(oid == oid2)
            }
            else {
                XCTFail()
            }
        }
    }
}
