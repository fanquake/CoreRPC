# Testnet Explorer

This application serves as a simple example of what can be done using CoreRPC.

## Setup & build bitcoind

Acquire the [Bitcoin Core](https://github.com/bitcoin/bitcoin) source and [install dependencies](https://github.com/bitcoin/bitcoin/blob/master/doc/build-osx.md).
Compile:
```bash
./autogen.sh
./configure --with-gui=no
make check -j4
```

Generate credentials and setup bitcoin.conf:
```bash
python3 share/rpcauth/rpcauth.py your_username

# Add the rpcauth string to bitcoin.conf:
rpcauth=your_username:8e80e6cbd....
# along with:
testnet=1
server=1
```

Run bitcoind:
```bash
src/bitcoind -debug=rpc
....
ThreadRPCServer method=getblockchaininfo user=your_username
...
ThreadRPCServer method=getblock user=your_username

```

## Setup & build Explorer

Either set the `CORERPC_USER` and `CORERPC_PASS` environment variables, or pass them when running the binary, i.e:
```
CORERPC_USER=your_username CORERPC_PASS=xxx swift run
```

Build and run `Explorer`:
```bash
swift build
swift run

# If you want an Xcode project to use for building/running:
swift package generate-xcodeproj
open Explorer.xcodeproj
```

## Usage

Query `Explorer` with a browser or using curl. i.e:

```bash
curl http://localhost:8080/info

{
    "blocks":1449824,
    "bestblockhash":"0000000000000069bc3d40b3c5702ea428e83f87cdc134c2e440c645e3f43388",
    "chain":"test",
    "mediantime":1545963286,
    "chainwork":"0000000000000000000000000000000000000000000000e0df7117c1efb1f389",
    "pruned":false,
    "headers":1449824,
    "size_on_disk":23177236575,
    "bip9_softforks":{"csv":{"startTime":1456790400,"status":"active","since":770112,"timeout":1493596800},
                        "segwit":{"startTime":1462060800,"status":"active","since":834624,"timeout":1493596800}},
    "softforks":[
        {"id":"bip34","version":2,"reject":{"status":true}},
        {"id":"bip66","version":3,"reject":{"status":true}},
        {"id":"bip65","version":4,"reject":{"status":true}}
    ],
    "difficulty":13305759.81218157,
    "verificationprogress":0.99998998737977485,
    "warnings":"This is a pre-release test build - use at your own risk - do not use for mining or merchant applications",
    "initialblockdownload":false
}

curl http://localhost:8080/tips

[
    {
        "status":"active",
        "hash":"0000000000000069bc3d40b3c5702ea428e83f87cdc134c2e440c645e3f43388",
        "height":1449824,
        "branchlen":0
    },
    {
        "status":"headers-only",
        "hash":"00000000210004840364b52bc5e455d888f164e4264a4fec06a514b67e9d5722",
        "height":1414433,
        "branchlen":23
    }
]

curl http://localhost:8080/block/0000000000011fbc6a4d9fe6260197bfa098e7f9ccb7e2a1184f3f28f8a86f50

{
    "hash":"0000000000011fbc6a4d9fe6260197bfa098e7f9ccb7e2a1184f3f28f8a86f50",
    "mediantime":1545955955,"chainwork":"0000000000000000000000000000000000000000000000e0d918d4672cfe2345",
    "nonce":3605453829,
    "nTx":101,
    "version":536870912,
    "time":1545958797,
    "merkleroot":"cf887c5c3ed2e046c758dffeda167d3a0b1dfc24c45f67c0b44e8a76db0fd387",
    "size":34393,
    "confirmations":14,
    ... etc
```
