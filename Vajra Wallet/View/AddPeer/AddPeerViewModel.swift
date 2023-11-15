//
//  AddPeerViewModel.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import Foundation

class AddPeerViewModel {
    var ldkNode: LDKNodeManager = LDKNodeManager.shared
    func connectPeer(peerPubkeyIp: String) -> Bool? {
        let pubkeyIp = peerPubkeyIp.components(separatedBy: "@")
        if pubkeyIp.count < 2 {
            return false
        }
        do {
            try ldkNode.connectPeer(nodeId: pubkeyIp[0], address: pubkeyIp[1], persist: false)
            return true
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
