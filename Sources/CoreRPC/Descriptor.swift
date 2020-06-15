import Foundation
import PromiseKit

public extension CoreRPC {

    struct DescriptorInfo: Codable {
        let checksum: String
        let descriptor: String
        let isrange: Bool
        let issolvable: Bool
        let hasprivatekeys: Bool
    }

    func getDescriptorInfo(_ descriptor: String) -> Promise<DescriptorInfo> {
        return call(method: .getdescriptorinfo, params: [descriptor])
    }

    func deriveAddress(for descriptor: String) -> Promise<[String]> {

        return call(method: .deriveaddresses, params: [descriptor])
    }

    func deriveAddresses(for descriptor: String, with range: [Int]) -> Promise<[String]> {

        struct deriveAddressesParams: Codable {
            let descriptor: String
            let range: [Int]
        }

        let params = deriveAddressesParams(descriptor: descriptor, range: range)

        return call(method: .deriveaddresses, params: params)
    }
}
