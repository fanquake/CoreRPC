import Foundation
import PromiseKit

public extension CoreRPC {

    func getTransaction(hex: String) -> Promise<SimpleTransaction> {
        return call(method: .gettransaction, params: [hex])
    }

    func decodeRawTransaction(hex: String) -> Promise<Transaction> {
        return call(method: .decoderawtransaction, params: [hex])
    }

    func getRawTransaction(txid: String) -> Promise<String> {
        return call(method: .getrawtransaction, params: [txid])
    }

    struct CreateRawParams: Codable {

        public struct Input: Codable {
            public let txid: String
            public let vout: Int
            public let sequence: Int?

            public init(txid: String, vout: Int, sequence: Int?) {
                self.txid = txid
                self.vout = vout
                self.sequence = sequence
            }
        }

        public struct AddressOutput: Codable {
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

            enum DecodingKeys: String, CodingKey {
                case address
                case amount
            }

            public init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: DecodingKeys.self)
                address = try values.decode(String.self, forKey: .address)
                amount = try values.decode(Double.self, forKey: .amount)
            }

            public init(address: String, amount: Double) {
                self.address = address
                self.amount = amount
            }
        }

        public struct DataOutput: Codable {
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

    struct FundedRawTransaction: Codable {
        public let hex: String
        public let fee: Double
        public let changepos: Int
    }

    func fundRawTransaction(hex: String) -> Promise<FundedRawTransaction> {
        return call(method: .fundrawtransaction, params: [hex])
    }

    struct SignedRawTransaction: Codable {

        public struct SigningError: Codable {
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

    struct SimpleTransaction: Codable {

        public enum Replaceable: String {
            case no
            case unknown
            case yes
        }

        public enum Category: String, Codable {
            case immature
            case generate
            case orphan
            case receive
            case send

        }

        public struct Details: Codable {
            public let abandoned: Bool?
            public let address: String?
            public let amount: Double
            public let category: Category
            public let fee: Double
            public let label: String?
            public let vout: Int
        }

        public let amount: Double
        //public let bip125-replaceable: Replaceable
        public let blockhash: String?
        public let blockindex: Int?
        public let blocktime: Int?
        public let confirmations: Int
        public let details: [Details]
        public let fee: Double
        public let hex: String
        public let time: Int
        public let timereceived: Int
        public let txid: String
    }
    
    struct Transaction: Codable {
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
