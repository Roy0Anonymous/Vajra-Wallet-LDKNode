//
//  AddPeerView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import SwiftUI

struct AddPeerView: View {
    @State private var nodeIdIp: String = ""
    private var viewModel = AddPeerViewModel()
    @State private var isConnected: Bool = false
    @State private var errorConnecting: Bool = false
    var body: some View {
        VStack {
            CustomTextField(textContent: $nodeIdIp, placeholder: "Enter Node ID and Address")
                .padding()
            CustomButtons(label: "Connect")
                .frame(width: 100)
                .onTapGesture {
                    let connected = viewModel.connectPeer(peerPubkeyIp: nodeIdIp)
                    if let connected = connected, connected {
                        isConnected = true
                    } else {
                        errorConnecting = true
                    }
                }
                .alert("Connected Successfully", isPresented: $isConnected) {}
                .alert("Failed to Connect", isPresented: $errorConnecting) {}
        }
    }
}

#Preview {
    AddPeerView()
}
