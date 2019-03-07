import Foundation
import PromiseKit

public extension CoreRPC {

    struct DescriptorInfo: Codable {
        let descriptor: String
        let isrange: Bool
        let issolvable: Bool
        let hasprivatekeys: Bool
    }

    func getDescriptorInfo(_ descriptor: String) -> Promise<DescriptorInfo> {
        return call(method: .getdescriptorinfo, params: [descriptor])
    }

}
