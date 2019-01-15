import Foundation
import PromiseKit
import PMKFoundation

public struct RPCError: Decodable {
    public let code: RPCErrorCode
    public let message: String
}

public struct RPCResult<T: Decodable>: Decodable {
    public let id: String?
    public let error: RPCError?
    public let result: T?
}

public struct Empty : Encodable {}

public enum CoreRPCError: Error {
    case callFailed(RPCMethod, RPCErrorCode, String)
    case decodingFailed(String)
    case missingEnvCredentails
    case invalidURL
}

public class CoreRPC {
    
    let connection: URLSession
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    var dataTask: URLSessionDataTask?
    var request: URLRequest

    public init(url: URL) throws {

        guard let username = ProcessInfo.processInfo.environment["CORERPC_USER"],
            let password = ProcessInfo.processInfo.environment["CORERPC_PASS"] else {
                throw CoreRPCError.missingEnvCredentails
        }

        connection = URLSession(configuration: .default)
        decoder = JSONDecoder()
        encoder = JSONEncoder()


        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.user = username
        components?.password = password

        guard let rpc = components?.url else {
            throw CoreRPCError.invalidURL
        }

        request = URLRequest(url: rpc)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("CoreRPC/0.1", forHTTPHeaderField: "User-Agent")
    }

    struct BodyContent<P: Encodable>: Encodable {
        let jsonrpc = 1.0
        let id = "CoreRPC"
        let method: RPCMethod
        let params: P
    }
    
    internal func call<T: Decodable, P: Encodable>(method: RPCMethod, params: P) -> Promise<T> {
        
        let newBody = BodyContent(method: method, params: params)
        let encoded = try? encoder.encode(newBody)
        
        request.httpBody = encoded
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: request)
        }.compactMap {
            let rpcResult: RPCResult<T>

            do {
                rpcResult = try self.decoder.decode(RPCResult<T>.self, from: $0.data)
            } catch {
                throw CoreRPCError.decodingFailed(error.localizedDescription)
            }

            if let error = rpcResult.error {
                throw CoreRPCError.callFailed(method, error.code, error.message)
            }

            return rpcResult.result
        }.map {
            return $0
        }
    }
}
