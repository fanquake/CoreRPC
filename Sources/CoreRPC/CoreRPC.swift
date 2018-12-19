import Foundation
import PromiseKit
import PMKFoundation

public struct RPCError: Decodable {
    public let code: RPCErrorCode.RawValue?
    public let message: String
}

public struct RPCResult<T: Decodable>: Decodable {
    public let id: String?
    public let error: RPCError?
    public let result: T?
}

public struct BodyContent<P: Encodable>: Encodable {
    let jsonrpc = 1.0
    let id = "CoreRPC"
    let method: RPCMethod.RawValue
    let params: P
}

public struct Empty : Encodable {}

public class CoreRPC {
    
    let connection: URLSession
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    var dataTask: URLSessionDataTask?
    var request: URLRequest
    
    // TODO: Set port and chain via flag/param
    public init(node: URL) {
        connection = URLSession(configuration: .default)
        decoder = JSONDecoder()
        encoder = JSONEncoder()
        
        request = URLRequest(url: node)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("CoreRPC/0.1", forHTTPHeaderField: "User-Agent")
    }
    
    internal func call<T: Decodable, P: Encodable>(method: RPCMethod, params: P) -> Promise<T> {
        
        let newBody = BodyContent(method: method.rawValue, params: params)
        let encoded = try? encoder.encode(newBody)
        
        request.httpBody = encoded
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: request)
        }.compactMap {
            try self.decoder.decode(RPCResult<T>.self, from: $0.data).result
        }.map {
            return $0
        }
    }
}
