import Foundation
import PromiseKit

public extension CoreRPC {

    func getAddressInfo(address: String) -> Promise<AddressInfo> {
        return call(method: .getaddressinfo, params: [address])
    }

    public enum AddressType: String, Codable {
        case bech32
        case legacy
        case p2sh_segwit = "p2sh-segwit"
    }

    func getNewAddress(label: String?, type: AddressType?) -> Promise<String> {

        struct newAddressParams: Codable {
            let label: String?
            let address_type: AddressType?
        }

        let params = newAddressParams(label: label, address_type: type)

        return call(method: .getnewaddress, params: params)
    }
    
    func getWalletInfo() -> Promise<WalletInfo> {
        return call(method: .getwalletinfo, params: Empty())
    }
    
    func listUnspent() -> Promise<[Unspent]> {
        return call(method: .listunspent, params: Empty())
    }

    func listWallets() -> Promise<[String]> {
        return call(method: .listwallets, params: Empty())
    }

    struct LoadedWallet: Codable {
        let name: String
        let warning: String
    }

    func loadWallet(name: String) -> Promise<LoadedWallet> {
        return call(method: .loadwallet, params: [name])
    }

    struct AddressInfo: Codable {
        public let address: String
        public let desc: String?
        public let hdkeypath: String?
        public let hdseedid: String?
        public let hex: String?
        public let ischange: Bool
        public let iscompressed: Bool?
        public let ismine: Bool
        public let isscript: Bool
        public let iswatchonly: Bool
        public let iswitness: Bool
        public let label: String? // optional because the default value is ""
        public let pubkey: String?
        public let pubkeys: [String]?
        public let script: Transaction.scriptPubKeyType?
        public let scriptPubKey: String
        public let sigsrequired: Int?
        public let solvable: Bool
        public let timestamp: Int?
        public let witness_program: String?
        public let witness_version: Int?
    }
    
    struct Unspent: Codable {
        let address: String
        public let amount: Double
        let confirmations: Int
        let label: String?
        let redeemScript: String?
        let scriptPubKey: String
        let safe: Bool
        let solvable: Bool
        let spendable: Bool
        let txid: String
        let vout: Int
    }
    
    struct WalletInfo: Codable {
        public let balance: Double // the total confirmed balance of the wallet
        public let hdseedid: String? // the Hash160 of the HD seed (only present when HD is enabled)
        public let hdmasterkeyid: String? // alias to hdseedid
        public let immature_balance: Double // the total immature balance of the wallet
        public let keypoololdest: Double // the timestamp (seconds since Unix epoch) of the oldest pre-generated key in the key pool
        public let keypoolsize: Int // how many new keys are pre-generated (only counts external keys)
        public let keypoolsize_hd_internal: Int // how many new keys are pre-generated for internal use
        // (used for change outputs, only appears if the wallet is using this feature, otherwise external keys are used)
        public let paytxfee: Double // the transaction fee configuration
        public let private_keys_enabled: Bool // false if privatekeys are disabled for this wallet (enforced watch-only wallet)
        public let txcount: Int // the total number of transactions in the wallet
        public let unconfirmed_balance: Double // // the total unconfirmed balance of the wallet
        public let unlocked_until: Int? // the timestamp in seconds since epoch (midnight Jan 1 1970 GMT) that the wallet is unlocked for transfers, or 0 if the wallet is locked
        public let walletname: String // the wallet name
        public let walletversion: Int // the wallet version
    }
}
