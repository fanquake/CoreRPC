//
//  Methods.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public enum RPCMethod: String {
    case getblockchaininfo = "getblockchaininfo"
    case getblock = "getblock"
    case getblockcount = "getblockcount"
    case getblockhash = "getblockhash"
    case getchaintips = "getchaintips"
    case getconnectioncount = "getconnectioncount"
    case getdifficulty = "getdifficulty"
    case getmemoryinfo = "getmemoryinfo"
    case getmempoolinfo = "getmempoolinfo"
    case getmininginfo = "getmininginfo"
    case getnettotals = "getnettotals"
    case getnetworkinfo = "getnetworkinfo"
    case getnewaddress = "getnewaddress"
    case getwalletinfo = "getwalletinfo"
    case listbanned = "listbanned"
}
