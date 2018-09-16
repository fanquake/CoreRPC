//
//  CoreRPCTests.swift
//  CoreRPCTests
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import XCTest
@testable import CoreRPC

class CoreRPCTests: XCTestCase {
    
    // TODO: Set via env variables?
    private let USER = ""
    private let PASS = ""
    
    var rpc: CoreRPC!

    override func setUp() {
        super.setUp()
        let node = URL(string: "http://\(USER):\(PASS)@127.0.0.1:18332")!
        rpc = CoreRPC(node: node)
    }
    
    func testGetBlockHash() {

        let expectation = self.expectation(description: "getBlockHash")
        let expected = "0000000095fab1da6dfa0a7169702e79e617b59afbcf7c00e5aaa1462abc1ac7"
        var hash: String?
        
        rpc.getBlockHash(block: 1413505) { h in
            hash = h.result
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(expected, hash)
    }
}
