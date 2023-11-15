//
//  CreateChannelViewModel.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import Foundation
import LDKNode

class CreateChannelViewModel {
    var ldkNode: LDKNodeManager = LDKNodeManager.shared
    func createChannel(nodeIdIp: String, amount: UInt64) -> Bool {
        let pubkeyIp = nodeIdIp.components(separatedBy: "@")
        if pubkeyIp.count < 2 {
            return false
        }
        do {
            try ldkNode.createChannel(nodeId: pubkeyIp[0], address: pubkeyIp[1], channelAmountSats: amount, pushToCounterpartyMsat: 0, channelConfig: nil, announceChannel: true)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
