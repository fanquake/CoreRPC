import Foundation
import PromiseKit

public extension CoreRPC {

    func decodeRawTransaction(hex: String) -> Promise<Transaction> {
        return call(method: .decoderawtransaction, params: [hex])
    }

    func getRawTransaction(txid: String) -> Promise<String> {
        return call(method: .getrawtransaction, params: [txid])
    }

    public struct CreateRawParams: Encodable {

        public struct Input: Encodable {
            public let txid: String
            public let vout: Int
            public let sequence: Int?

            public init(txid: String, vout: Int, sequence: Int?) {
                self.txid = txid
                self.vout = vout
                self.sequence = sequence
            }
        }

        public struct AddressOutput: Encodable {
            public let address: String
            public let amount: Double

            struct CodingKeys: CodingKey {
                
                var stringValue: String
                init?(stringValue: String) {
                    self.stringValue = stringValue
                }

                // Required for CodingKey conformance
                var intValue: Int?
                init?(intValue: Int) { return nil }
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)

                guard let address = CodingKeys.init(stringValue: self.address) else { return }
                try container.encode(amount, forKey: address)
            }

            public init(address: String, amount: Double) {
                self.address = address
                self.amount = amount
            }
        }

        public struct DataOutput: Encodable {
            public let data: String

            public init(data: String) {
                self.data = data
            }
        }

        public let inputs: [Input]
        public let outputs: [DataOutput] // TODO: include addressOutput
        public let locktime: Int?
        public let replaceable: Bool?

        public init(inputs: [Input], outputs: [DataOutput], locktime: Int?, replaceable: Bool?) {
            self.inputs = inputs
            self.outputs = outputs
            self.locktime = locktime
            self.replaceable = replaceable
        }
    }

    func createRawTransaction(params: CreateRawParams) -> Promise<String> {
        return call(method: .createrawtransaction, params: params)
    }

    public struct FundedRawTransaction: Decodable {
        public let hex: String
        public let fee: Double
        public let changepos: Int
    }

    func fundRawTransaction(hex: String) -> Promise<FundedRawTransaction> {
        return call(method: .fundrawtransaction, params: [hex])
    }

    public struct SignedRawTransaction: Decodable {

        public struct SigningError: Decodable {
            public let txid: String
            public let vout: Int
            public let scriptSig: String
            public let sequence: Int
            public let error: String
        }

        public let complete: Bool
        public let errors: [SigningError]?
        public let hex: String
    }

    func signRawTransactionWithWallet(hex: String) -> Promise<SignedRawTransaction> {
        return call(method: .signrawtransactionwithwallet, params: [hex])
    }

    func sendrawtransaction(hex: String) -> Promise<String> {
        return call(method: .sendrawtransaction, params: [hex])
    }
    
    public struct Transaction: Codable {
        public let hash: String
        public let hex: String?
        public let locktime: Int
        public let size: Int
        public let txid: String
        public let version: Int
        public let vin: [vIn]
        public let vout: [vOut]
        public let vsize: Int
        public let weight: Int
        
        public struct vIn: Codable {
            public let coinbase: String?
            public let scriptSig: scriptSig?
            public let sequence: Int
            public let txid: String?
            public let txinwitness: [String]?
            public let vout: Int?
        }
        
        public struct vOut: Codable {
            public let n: Int
            public let scriptPubKey: scriptPubKey
            public let value: Double
        }
        
        public struct scriptSig: Codable {
            public let asm: String
            public let hex: String
        }

        public enum scriptPubKeyType: String, Codable {
            case multisig
            case nonstandard
            case nulldata
            case pubkey
            case pubkeyhash
            case scripthash
            case witness_v0_keyhash
            case witness_v0_scripthash
            case witness_unknown
        }

        public struct scriptPubKey: Codable {
            public let addresses: [String]?
            public let asm: String
            public let hex: String
            public let reqSigs: Int?
            public let type: scriptPubKeyType
        }
        
        public func isCoinbase() -> Bool {
            return vin.contains(where: {$0.coinbase != nil})
        }
    }
}
