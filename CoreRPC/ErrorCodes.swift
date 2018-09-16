//
//  ErrorCodes.swift
//  CoreRPC
//
//  Copyright © 2018 fanquake. All rights reserved.
//

import Foundation

// https://github.com/bitcoin/bitcoin/blob/master/src/rpc/protocol.h

public enum RPCErrorCode: Int, Codable {
    // Standard JSON-RPC 2.0 errors
    case RPC_INVALID_REQUEST = -32600
    case RPC_METHOD_NOT_FOUND = -32601
    case RPC_INVALID_PARAMS = -32602
    case RPC_INTERNAL_ERROR = -32603
    case RPC_PARSE_ERROR = -32700
    
    // General Core errors
    case RPC_MISC_ERROR = -1 // std::exception thrown in command handling
    case RPC_TYPE_ERROR = -3 // Unexpected type was passed as parameter
    case RPC_INVALID_ADDRESS_OR_KEY = -5 // Invalid address or key
    case RPC_OUT_OF_MEMORY = -7 // Ran out of memory during operation
    case RPC_INVALID_PARAMETER = -8 // Invalid, missing or duplicate parameter
    case RPC_DATABASE_ERROR = -20 // Database error
    case RPC_DESERIALIZATION_ERROR = -22 // Error parsing or validating structure in raw format
    case RPC_VERIFY_ERROR = -25 // General error during transaction or block submission
    case RPC_VERIFY_REJECTED = -26 // Transaction or block was rejected by network rules
    case RPC_VERIFY_ALREADY_IN_CHAIN = -27 // Transaction already in chain
    case RPC_IN_WARMUP = -28 // Client still warming up
    case RPC_METHOD_DEPRECATED = -32 // RPC method is deprecated
    
    // P2P client errors
    case RPC_CLIENT_NOT_CONNECTED = -9 // Core is not connected
    case RPC_CLIENT_IN_INITIAL_DOWNLOAD = -10 // Still downloading initial blocks
    case RPC_CLIENT_NODE_ALREADY_ADDED = -23 // Node is already added
    case RPC_CLIENT_NODE_NOT_ADDED = -24 // Node has not been added before
    case RPC_CLIENT_NODE_NOT_CONNECTED = -29 // Node to disconnect not found in connected nodes
    case RPC_CLIENT_INVALID_IP_OR_SUBNET = -30 // Invalid IP/Subnet
    case RPC_CLIENT_P2P_DISABLED = -31 // No valid connection manager instance found
    
    // Wallet Errors
    case RPC_WALLET_ERROR = -4 // Unspecified problem with wallet (key not found etc.)
    case RPC_WALLET_INSUFFICIENT_FUNDS = -6 // Not enough funds in wallet or account
    case RPC_WALLET_INVALID_LABEL_NAME = -11 // Invalid label name
    case RPC_WALLET_KEYPOOL_RAN_OUT = -12 // Keypool ran out, call keypoolrefill first
    case RPC_WALLET_UNLOCK_NEEDED = -13 // Enter the wallet passphrase with walletpassphrase first
    case RPC_WALLET_PASSPHRASE_INCORRECT = -14 // The wallet passphrase entered was incorrect
    case RPC_WALLET_WRONG_ENC_STATE = -15 // Command given in wrong wallet encryption state (encrypting an encrypted wallet etc.)
    case RPC_WALLET_ENCRYPTION_FAILED = -16 // Failed to encrypt the wallet
    case RPC_WALLET_ALREADY_UNLOCKED = -17 // Wallet is already unlocked
    case RPC_WALLET_NOT_FOUND = -18 // Invalid wallet specified
    case RPC_WALLET_NOT_SPECIFIED = -19 // No wallet specified (error when there are multiple wallets loaded)
    
    // Unused reserved codes, kept around for backwards compatibility. DO NOT REUSE.
    case RPC_FORBIDDEN_BY_SAFE_MODE = -2 // Server is in safe mode, and command is not allowed in safe mode
}
