//
//  LightningViewModel.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 15/11/23.
//

import Foundation
import LDKNode

class LightningViewModel {
    private var peers: [PeerDetails] = []
    private var channels: [ChannelDetails] = []
    let ldkNode: LDKNodeManager = LDKNodeManager.shared
    func getPeers() -> [PeerDetails] {
        peers = ldkNode.listPeers()
        return peers
    }
    func getChannels() -> [ChannelDetails] {
        channels = ldkNode.listChannels()
        return channels
    }
}
