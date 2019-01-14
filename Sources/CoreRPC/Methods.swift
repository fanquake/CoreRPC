import Foundation

public enum RPCMethod: String, Encodable {
    case createrawtransaction = "createrawtransaction"
    case fundrawtransaction = "fundrawtransaction"
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
    case listunspent = "listunspent"
    case sendrawtransaction = "sendrawtransaction"
    case signrawtransactionwithwallet = "signrawtransactionwithwallet"
}
