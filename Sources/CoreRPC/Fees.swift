import Foundation
import PromiseKit

public extension CoreRPC {

    public enum EstimateMode: String, Encodable {
        case CONSERVATIVE
        case ECONOMICAL
        case UNSET
    }

    struct EstimatedFee: Decodable {
        let blocks: Int
        let errors: [String]?
        let feerate: Double?
    }

    func estimateSmartFee(target: Int, mode: EstimateMode?) -> Promise<EstimatedFee> {

        struct estimateParams: Encodable {
            let conf_target: Int?
            let estimate_mode: EstimateMode?
        }

        let params = estimateParams(conf_target: target, estimate_mode: mode)

        return call(method: .estimatesmartfee, params: params)
    }
}
