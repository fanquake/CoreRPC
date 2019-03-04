# CoreRPC

Swift wrapper for the [Bitcoin Core](https://github.com/bitcoin/bitcoin) [RPC](https://bitcoin.org/en/developer-reference#remote-procedure-calls-rpcs).

⚠️ Warning - This repository is not yet ready for use in production. ⚠️

The plan is an initial release in line with the Bitcoin Core [0.18.0 release](https://bitcoincore.org/en/lifecycle/#schedule).

Build:
```bash
swift build
swift test

# If you want an Xcode project
swift package generate-xcodeproj
```

Add to your own project with:
```swift
.package(url: "https://github.com/fanquake/CoreRPC", .branch("master"))
```

```swift
import CoreRPC
import PromiseKit

let node = URL(string: "http://localhost:18332") // testnet
let rpc = CoreRPC(url: node)

firstly {
    rpc.getVerboseBlock(hash: "0000000014e6ae5aef5b7b660b160b7572fe14b95609fefb6f87c2d2e33a5fdd")
}.done { block in
    print(block.confirmations, block.merkleroot)
    // 31165 "d20cdbe39d1528bacfab6f7a3c16d576aeae6e8fb993193692a918a7c5002450"

    let coinbase = block.tx.filter({ $0.isCoinbase() })
    print(coinbase.first!.txid)
    // "5b824f055bc4ea8763a817bd951c53f38f81d3c4f2066c6eee79acbad2819db7"
}.catch { err in
    print(err)
}
```

### Configuration
The preferred configuration method is to set `CORERPC_USER` and `CORERPC_PASS` environment variables.

If found, they will be inserted into the given URL.

It is also possible to pass a fully formed URL, such as `http://username:password@localhost:8332`.

## Swift Playground
An easy way to try this repo is with a [Swift Playground](https://developer.apple.com/swift-playgrounds).
```bash
git clone https://github.com/fanquake/corerpc.git

cd corerpc

swift package generate-xcodeproj
open CoreRPC.xcodeproj
```

Inside Xcode:
- File -> New -> Playground
- iOS (Blank) is fine.
- Name the file `Test.Playground` and save it inside the `corerpc` directory.
    * Add to: CoreRPC
    * Group: CoreRPC
- Create

Copy the following into the Playground:
```swift
import CoreRPC
import Foundation
import PlaygroundSupport
import PromiseKit

PlaygroundPage.current.needsIndefiniteExecution = true
```

Then you can use as normal. i.e:
```swift
let node = URL(string: "http://username:password@localhost:18332")!
let rpc = try CoreRPC.init(url: node)

firstly {
    rpc.getBlockHash(block: 554000)
}.then { hash in
    rpc.getVerboseBlock(hash: hash)
}.done { block in
    print("Tx count: \(block.tx.count)")
}.catch { error in
    print(error)
}
```

![Playground](playground.png)

## Testnet Block Explorer
An example block explorer application is available [here](Example/README.md).
