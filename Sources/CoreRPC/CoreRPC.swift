import Foundation
import PromiseKit
import PMKFoundation

public struct RPCError: Codable {
    public let code: RPCErrorCode.RawValue?
    public let message: String
}

public struct RPCResult<T: Codable>: Codable {
    public let id: String?
    public let error: RPCError?
    public let result: T?
}

public class CoreRPC {
    
    let connection: URLSession
    let decoder: JSONDecoder
    var dataTask: URLSessionDataTask?
    var request: URLRequest
    
    // TODO: Set port and chain via flag/param
    public init(node: URL) {
        connection = URLSession(configuration: .default)
        decoder = JSONDecoder()
        
        request = URLRequest(url: node)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("CoreRPC/0.1", forHTTPHeaderField: "User-Agent")
    }
    
    internal func call<T: Codable>(method: RPCMethod, params: Any?) -> Promise<T> {
        var body: [String: Any] = ["jsonrpc": 1.0,
                                   "id": "CoreRPC",
                                   "method": method.rawValue]
        
        body["params"] = params ?? nil
        
        let payload = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = payload
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: request)
        }.compactMap {
            // try decode into RPC result
            let result = try self.decoder.decode(RPCResult<T>.self, from: $0.data)
            debugPrint(result)
            // TODO: Check for errors in here
            return result.result
        }
    }
}
