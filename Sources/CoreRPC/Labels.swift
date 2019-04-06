import Foundation
import PromiseKit

public extension CoreRPC {

    enum LabelType: String, Codable {
        case all = ""
        case receive
        case send
    }

    func listLabels(_ type: LabelType) -> Promise<[String]> {
        return call(method: .listlabels, params: [type])
    }
}
