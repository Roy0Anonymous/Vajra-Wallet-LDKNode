//
//  LDKNodeManager.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 11/11/23.
//

import Foundation
import LDKNode

class LDKNodeManager {
    static let shared = LDKNodeManager()
    private var ldkNode: LdkNode
    private var mnemonic: Mnemonic? = nil
    init() {
        let builder = Builder()
        mnemonic = generateEntropyMnemonic()
        builder.setEntropyBip39Mnemonic(mnemonic: mnemonic!, passphrase: nil)
        builder.setNetwork(network: .regtest)
        builder.setEsploraServer(esploraServerUrl: "http://127.0.0.1:3002") // "https://mempool.space/testnet/api" "http://127.0.0.1:3002"
//        let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.path ?? ""
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path ?? ""
//        builder.setStorageDirPath(storageDirPath: libraryDirectory)
        builder.setStorageDirPath(storageDirPath: documentsDirectory)
        let node = try! builder.build()
        ldkNode = node
    }
    
    //        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path ?? ""
    //        let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first?.path ?? ""
    //        builder.setStorageDirPath(storageDirPath: documentsDirectory)
    //        let config = Config(
    //            storageDirPath: libraryDirectory,
    //            network: .testnet,
    //            listeningAddress: "0.0.0.0:9735",
    //            defaultCltvExpiryDelta: UInt32(144),
    //            onchainWalletSyncIntervalSecs: UInt64(60),
    //            walletSyncIntervalSecs: UInt64(20),
    //            feeRateCacheUpdateIntervalSecs: UInt64(600),
    //            logLevel: .debug
    //        )
    //        let nodeBuilder = Builder.fromConfig(config: config)
    
    func start() {
        try! ldkNode.start()
    }
    
    func stop() throws {
        try ldkNode.stop()
    }
    
    func getMnemonic() -> Mnemonic {
        return mnemonic ?? ""
    }
    
    func syncWallet() {
        try! self.ldkNode.syncWallets()
    }
    
    func balance() -> UInt64 {
        return try! ldkNode.totalOnchainBalanceSats()
    }
    
    func getAddress() -> String {
        return try! ldkNode.newOnchainAddress().lowercased()
    }
    
    func sendOnchain(address: String, amount: UInt64) throws -> Txid {
        let res = try ldkNode.sendToOnchainAddress(address: Address(stringLiteral: address), amountMsat: amount)
        return res
    }
    
    func listChannels() -> [ChannelDetails] {
        return ldkNode.listChannels()
    }
    
    func listPeers() -> [PeerDetails] {
        return ldkNode.listPeers()
    }
    
    func connectPeer(nodeId: PublicKey, address: NetAddress, persist: Bool) throws {
        try ldkNode.connect(nodeId: nodeId, address: address, persist: persist)
    }
    
    func createChannel(nodeId: PublicKey, address: NetAddress, channelAmountSats: UInt64, pushToCounterpartyMsat: UInt64?, channelConfig: ChannelConfig?, announceChannel: Bool) throws {
        try ldkNode.connectOpenChannel(nodeId: nodeId, address: address, channelAmountSats: channelAmountSats, pushToCounterpartyMsat: pushToCounterpartyMsat, channelConfig: channelConfig, announceChannel: announceChannel)
    }
    
    func sendPayment(invoice: Invoice) throws -> PaymentHash? {
        print(invoice)
        do {
            let res = try ldkNode.sendPayment(invoice: invoice)
            print("We have hash \(res)")
            return res
        } catch {
            print("Send failed lightning")
            return nil
        }
    }
}
