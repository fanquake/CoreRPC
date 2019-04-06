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
    case decodingFailed(RPCMethod, Error)
    case missingEnvCredentials
    case invalidURL

    public func message() -> String {
        switch self {
        case .callFailed(let method, _, let error):
            return "Call \(method.rawValue) failed with: \(error)."
        case .decodingFailed(let method, let error):
            return "Decoding response from \(method.rawValue) failed with \(error.localizedDescription)."
        case .missingEnvCredentials:
            return "Credentials have not been set."
        case .invalidURL:
            return "URL is invalid."
        }
    }
}

public class CoreRPC {
    
    let connection: URLSession
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    var request: URLRequest

    public init(url: URL) throws {

        connection = URLSession(configuration: .default)
        decoder = JSONDecoder()
        encoder = JSONEncoder()

        if url.user != nil, url.password != nil {
            request = URLRequest(url: url)
        } else {

            guard let username = ProcessInfo.processInfo.environment["CORERPC_USER"],
                let password = ProcessInfo.processInfo.environment["CORERPC_PASS"] else {
                    throw CoreRPCError.missingEnvCredentials
            }

            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.user = username
            components?.password = password

            guard let rpc = components?.url else {
                throw CoreRPCError.invalidURL
            }
            request = URLRequest(url: rpc)
        }

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("CoreRPC/0.1", forHTTPHeaderField: "User-Agent")
    }

    struct BodyContent<P: Encodable>: Encodable {
        let jsonrpc = 2.0
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
                throw CoreRPCError.decodingFailed(method, error)
            }

            if let error = rpcResult.error {
                throw CoreRPCError.callFailed(method, error.code, error.message)
            }

            return rpcResult.result
        }
    }
}
