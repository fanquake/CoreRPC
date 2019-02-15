import Foundation
import PromiseKit

public extension CoreRPC {

    public enum EstimateMode: String, Codable {
        case CONSERVATIVE
        case ECONOMICAL
        case UNSET
    }

    struct EstimatedFee: Codable {
        let blocks: Int
        let errors: [String]?
        let feerate: Double?
    }

    func estimateSmartFee(target: Int, mode: EstimateMode?) -> Promise<EstimatedFee> {

        struct estimateParams: Codable {
            let conf_target: Int?
            let estimate_mode: EstimateMode?
        }

        let params = estimateParams(conf_target: target, estimate_mode: mode)

        return call(method: .estimatesmartfee, params: params)
    }

    func setTxFee(fee: Decimal) -> Promise<Bool> {

        struct setTxFeeParams: Codable {
            let amount: Decimal
        }

        let params = setTxFeeParams(amount: fee)

        return call(method: .settxfee, params: params)
    }
}
