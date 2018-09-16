//
//  Wallet.swift
//  CoreRPC
//
//  Created by Michael on 15/9/18.
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public extension CoreRPC {
    func getWalletInfo(completion: @escaping (RPCResult<WalletInfo>) -> Void) {
        call(method: .getwalletinfo, params: nil) { result in
            completion(result.result!)
        }
    }
    
    struct WalletInfo: Codable {
        let balance: Int // the total confirmed balance of the wallet
        let hdseedid: String? // the Hash160 of the HD seed (only present when HD is enabled)
        let hdmasterkeyid: String? // alias to hdseedid
        let immature_balance: Int // the total immature balance of the wallet
        let keypoololdest: Double // the timestamp (seconds since Unix epoch) of the oldest pre-generated key in the key pool
        let keypoolsize: Int // how many new keys are pre-generated (only counts external keys)
        let keypoolsize_hd_internal: Int // how many new keys are pre-generated for internal use
        // (used for change outputs, only appears if the wallet is using this feature, otherwise external keys are used)
        let paytxfee: Double // the transaction fee configuration
        let private_keys_enabled: Bool // false if privatekeys are disabled for this wallet (enforced watch-only wallet)
        let txcount: Int // the total number of transactions in the wallet
        let unconfirmed_balance: Int // // the total unconfirmed balance of the wallet
        let unlocked_until: Int? // the timestamp in seconds since epoch (midnight Jan 1 1970 GMT) that the wallet is unlocked for transfers, or 0 if the wallet is locked
        let walletname: String // the wallet name
        let walletversion: Int // the wallet version
    }
}
