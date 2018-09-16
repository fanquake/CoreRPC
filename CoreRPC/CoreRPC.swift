//
//  CoreRPC.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

public struct RPCError: Codable {
    var code: RPCErrorCode.RawValue?
    var message: String
}

public struct RPCResult<T: Codable>: Codable {
    var id: String?
    var error: RPCError?
    var result: T?
}

public class CoreRPC {
    
    var connection: URLSession
    var decoder: JSONDecoder
    var dataTask: URLSessionDataTask?
    var request: URLRequest

    public init(node: URL!) {
        connection = URLSession(configuration: .default)
        decoder = JSONDecoder()
        
        request = URLRequest(url: node)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("CoreRPC/0.1", forHTTPHeaderField: "User-Agent")
        request.timeoutInterval = 10.0
    }

    // TODO: internal?
    func call<T: Codable>(method: RPCMethod, params: Any?, completion: @escaping (RPCResult<T>) -> Void) {

        var body: [String: Any] = ["jsonrpc": 1.0,
                                   "id": "CoreRPC",
                                   "method": method.rawValue]

        if let params = params {
            body["params"] = params
        }

        guard let payload = try? JSONSerialization.data(withJSONObject: body) else {
            print("Could not encode JSON data!")
            return
        }
        request.httpBody = payload

        dataTask = connection.dataTask(with: request) { data, response, error in

            // DataTask failed
            guard error == nil else {
                let msg = error?.localizedDescription ?? "No error message provided!"
                let rpcError = RPCError.init(code: nil, message: "DataTask error: \(msg)")
                let result = RPCResult<T>(id: nil, error: rpcError, result: nil)
                return completion(result)
            }
            
            guard let json = data, let result = try? self.decoder.decode(RPCResult<T>.self, from: json) else {
                if let data = data {
                    print(String(bytes: data, encoding: String.Encoding.utf8)!)
                    let rpcError = RPCError.init(code: nil, message: "Could not decode JSON data: \(data)")
                    let result = RPCResult<T>(id: nil, error: rpcError, result: nil)
                    return completion(result)
                } else {
                    let rpcError = RPCError.init(code: nil, message: "No data returned!")
                    let result = RPCResult<T>(id: nil, error: rpcError, result: nil)
                    return completion(result)
                }
            }
            
            // Have something to return
            //debugPrint(String(bytes: data!, encoding: String.Encoding.utf8)!)
            completion(result)
        }
        dataTask?.resume()
    }
}
