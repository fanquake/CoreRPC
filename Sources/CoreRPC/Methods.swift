import Foundation

public enum RPCMethod: String, Codable {
    case createrawtransaction = "createrawtransaction"
    case fundrawtransaction = "fundrawtransaction"
    case generatetoaddress = "generatetoaddress"
    case getaddressinfo = "getaddressinfo"
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
    case getrpcinfo = "getrpcinfo"
    case getwalletinfo = "getwalletinfo"
    case help = "help"
    case listbanned = "listbanned"
    case listunspent = "listunspent"
    case logging = "logging"
    case sendrawtransaction = "sendrawtransaction"
    case signrawtransactionwithwallet = "signrawtransactionwithwallet"
    case uptime = "uptime"
}
