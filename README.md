# CoreRPC

Swift wrapper for the [Bitcoin Core](https://github.com/bitcoin/bitcoin) [RPC](https://bitcoin.org/en/developer-reference#remote-procedure-calls-rpcs).

Build:
```
swift build
swift test

If you want an Xcode project:
swift package generate-xcodeproj
```

Add to your own project with:
```
.package(url: "https://github.com/fanquake/CoreRPC", .branch("master"))
```

```swift
import CoreRPC
import PromiseKit

let node = URL(string: "http://username:password@127.0.0.1:18332") // testnet
let rpc = CoreRPC(url: node)

firstly {
    rpc.getVerboseBlock(hash: "0000000014e6ae5aef5b7b660b160b7572fe14b95609fefb6f87c2d2e33a5fdd")
}.done { block in
    print(block.confirmations, block.merkleroot)
    // 31165 "d20cdbe39d1528bacfab6f7a3c16d576aeae6e8fb993193692a918a7c5002450"

    let coinbase = block.tx.filter({ $0.isCoinbaseTx() })
    print(coinbase.first!.txid)
    // "5b824f055bc4ea8763a817bd951c53f38f81d3c4f2066c6eee79acbad2819db7"
}.catch { err in
    debugPrint(err)
}
```
