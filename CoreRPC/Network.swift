//
//  Network.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    func getNetworkInfo(completion: @escaping (RPCResult<NetworkInfo>) -> Void) {
        call(method: .getnetworkinfo, params: nil) { result in
            completion(result.result!)
        }
    }
    
    struct Network: Codable {
        let limited: Bool
        let name: String
        let proxy: String
        let proxy_randomize_credentials: Bool
        let reachable: Bool
    }
    
    struct NetworkAddress: Codable {
        let address: String
        let port: Int
        let score: Int
    }
    
    struct NetworkInfo: Codable {
        let connections: Int
        let incrementalfee: Double
        let localaddresses: Array<NetworkAddress>
        let networkactive: Bool
        let networks: Array<Network>
        let localrelay: Bool
        let localservices: String
        let protocolversion: Int
        let relayfee: Double
        let subversion: String
        let timeoffset: Int
        let version: Int
        let warnings: String
    }
}
