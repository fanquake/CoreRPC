//
//  Utility.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    
    func getConnectionCount(completion: @escaping (RPCResult<Int>) -> Void) {
        call(method: .getconnectioncount, params: nil) { result in
            completion(result.result!)
        }
    }
    
    func getMemoryInfo(completion: @escaping (RPCResult<Memory>) -> Void) {
        call(method: .getmemoryinfo, params: nil) { result in
            completion(result.result!)
        }
    }
    
    func getNetTotals(completion: @escaping (RPCResult<NetworkTraffic>) -> Void) {
        call(method: .getnettotals, params: nil) { result in
            completion(result.result!)
        }
    }
    
    func listBanned(completion: @escaping (RPCResult<[bannedNode]>) -> Void) {
        call(method: .listbanned, params: nil) { result in
            completion(result.result!)
        }
    }
    
    struct bannedNode: Codable {
        let address: String
        let ban_created: Int
        let ban_reason: String
        let banned_util: Int
    }
    
    struct UploadTarget: Codable {
        let bytes_left_in_cycle: Int
        let target: Int
        let target_reached: Bool
        let timeframe: Int
        let time_left_in_cycle: Int
        let serve_historical_blocks: Bool
    }
    
    struct NetworkTraffic: Codable {
        let totalbytesrecv: Int
        let totalbytessent: Int
        let timemillis: Int
        let uploadtarget: UploadTarget
    }
    
    struct Locked: Codable {
        let chunks_free: Int
        let chunks_used: Int
        let free: Int
        let locked: Int
        let total: Int
        let used: Int
    }
    
    struct Memory: Codable {
        let locked: Locked
    }
}
