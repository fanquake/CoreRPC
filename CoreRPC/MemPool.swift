//
//  MemPool.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    
    func getMemPoolInfo(completion: @escaping (RPCResult<MemPoolInfo>) -> Void) {
        call(method: .getmempoolinfo, params: nil) { completion($0) }
    }
    
    struct MemPoolInfo: Codable {
        public let bytes: Int
        public let maxmempool: Int
        public let mempoolminfee: Double
        public let minrelaytxfee: Double
        public let size: Int
        public let usage: Int
    }
}
