//
//  CreateChannelView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import SwiftUI

struct CreateChannelView: View {
    @State private var nodeIdIp: String = ""
    @State private var amount: String = ""
    private var viewModel = CreateChannelViewModel()
    @State private var channelCreated: Bool = false
    @State private var errorConnecting: Bool = false
    var body: some View {
        VStack {
            CustomTextField(textContent: $nodeIdIp, placeholder: "Enter Node ID and Address")
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            CustomTextField(textContent: $amount, placeholder: "Enter Amount")
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            CustomButtons(label: "Connect")
                .frame(width: 100)
                .onTapGesture {
                    let res = viewModel.createChannel(nodeIdIp: nodeIdIp, amount: UInt64(amount) ?? 0)
                    if res {
                        channelCreated = true
                    } else {
                        errorConnecting = true
                    }
                }
                .alert("Connected Successfully", isPresented: $channelCreated) {}
                .alert("Failed to Connect", isPresented: $errorConnecting) {}
        }
    }
}

#Preview {
    CreateChannelView()
}
