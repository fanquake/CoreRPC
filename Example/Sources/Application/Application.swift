import CoreRPC
import Foundation
import Kitura
import PromiseKit

public class App {
    
    let node = URL(string: "http://your_username:your_generated_password@127.0.0.1:18332")!
    let router = Router()
    let rpc: CoreRPC
    
    public init() throws {
        // PromiseKit config
        let pmkQ = DispatchQueue(label: "pmkQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit)
        PromiseKit.conf.Q = (map: pmkQ, return: pmkQ)
        
        // Setup RPC
        rpc = CoreRPC(node: node)
    }

    func postInit() throws {
        
        self.router.get("/block") { (hash: String, respondWith: @escaping (CoreRPC.Block?, RequestError?) -> Void) -> Void in
            firstly {
                self.rpc.getBlock(hash: hash)
                }.done {
                    respondWith($0, nil)
                }.catch { err in
                    debugPrint(err)
            }
        }
        
        self.router.get("/info") { (respondWith: @escaping (CoreRPC.BlockchainInfo?, RequestError?) -> Void) -> Void in
            firstly {
                self.rpc.getBlockchainInfo()
                }.done {
                    respondWith($0, nil)
                }.catch { err in
                    debugPrint(err)
            }
        }
        
        self.router.get("/tips") { (respondWith: @escaping ([CoreRPC.ChainTip]?, RequestError?) -> Void) -> Void in
            firstly {
                self.rpc.getChainTips()
                }.done {
                    respondWith($0, nil)
                }.catch { err in
                    debugPrint(err)
            }
        }
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
    }
}
