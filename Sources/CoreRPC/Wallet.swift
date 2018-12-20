import Foundation

public extension CoreRPC {
    func getWalletInfo(completion: @escaping (RPCResult<WalletInfo>) -> Void) {
        call(method: .getwalletinfo, params: nil) { completion($0) }
    }
    
    struct WalletInfo: Codable {
        public let balance: Double // the total confirmed balance of the wallet
        public let hdseedid: String? // the Hash160 of the HD seed (only present when HD is enabled)
        public let hdmasterkeyid: String? // alias to hdseedid
        public let immature_balance: Int // the total immature balance of the wallet
        public let keypoololdest: Double // the timestamp (seconds since Unix epoch) of the oldest pre-generated key in the key pool
        public let keypoolsize: Int // how many new keys are pre-generated (only counts external keys)
        public let keypoolsize_hd_internal: Int // how many new keys are pre-generated for internal use
        // (used for change outputs, only appears if the wallet is using this feature, otherwise external keys are used)
        public let paytxfee: Double // the transaction fee configuration
        public let private_keys_enabled: Bool // false if privatekeys are disabled for this wallet (enforced watch-only wallet)
        public let txcount: Int // the total number of transactions in the wallet
        public let unconfirmed_balance: Int // // the total unconfirmed balance of the wallet
        public let unlocked_until: Int? // the timestamp in seconds since epoch (midnight Jan 1 1970 GMT) that the wallet is unlocked for transfers, or 0 if the wallet is locked
        public let walletname: String // the wallet name
        public let walletversion: Int // the wallet version
    }
}
