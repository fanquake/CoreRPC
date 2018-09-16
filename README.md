# CoreRPC

### Install with Carthage:
```
github "fanquake/CoreRPC" "master"
```

```
import CoreRPC

let node = URL(string: "http://username:password@127.0.0.1:18332") // testnet
let rpc = CoreRPC(url: node)

rpc.getVerboseBlock(hash: "0000000095fab1da6dfa0a7169702e79e617b59afbcf7c00e5aaa1462abc1ac7") { block in
    guard let b = block.result else { return }

    print(b.confirmations, b.merkleroot)
    -> 90 f9a2f70d36811783840a0aaf300f6f6bae04a156d88db6d17f71a5783bfd66e5

    let coinbase = b.tx.filter({ $0.isCoinbaseTx() })
    print(coinbase.first!.txid)
    -> a08fe2730882a45b26ec2937bd9da522d8aa16f43bf7c48cbb6f8ca8401fa098
}

```
