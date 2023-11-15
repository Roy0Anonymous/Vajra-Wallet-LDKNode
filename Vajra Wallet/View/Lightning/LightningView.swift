//
//  LightningView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 07/11/23.
//

import SwiftUI
import LDKNode

struct LightningView: View {
    @State private var sendClicked = false
    @State private var receiveClicked = false
    @State private var settingsClicked = false
    @Binding var isListPeers: Bool
    @State private var peers: [PeerDetails] = []
    @State private var channels: [ChannelDetails] = []
    var viewModel: LightningViewModel = LightningViewModel()
    var ldkNode: LDKNodeManager = LDKNodeManager.shared
    var body: some View {
        VStack {
            List {
                if isListPeers {
                    ForEach(peers, id: \.nodeId) { peer in
                        Text("\(peer.nodeId)")
                    }
                } else {
                    ForEach(channels, id: \.channelId) { channel in
                        VStack {
                            HStack {
                                if channel.isUsable {
                                    Image(systemName: "circlebadge.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circlebadge.fill")
                                        .foregroundColor(.red)
                                }
                                Text("\(channel.channelId)")
                            }
                            let value: Double = Double(channel.inboundCapacityMsat) / Double(channel.channelValueSats * 1000)
                            ProgressView(value: value, total: 1)
                            HStack {
                                Text("\(channel.inboundCapacityMsat)")
                                Spacer()
                                Text("\(channel.channelValueSats * 1000)")
                            }
                        }
                    }
                }
            }
            .refreshable {
                if isListPeers {
                    peers = viewModel.getPeers()
                } else {
                    channels = ldkNode.listChannels()
                }
            }
            .onAppear {
                peers = ldkNode.listPeers()
                channels = ldkNode.listChannels()
            }
            Spacer()
            customDoubleButtons
        }
    }
    
    var customDoubleButtons: some View {
        HStack(spacing: 10) {
            Spacer()
            Button(action: {
                sendClicked = true
            }, label: {
                MenuCell(image: Image(systemName: "arrow.up.right"), text: "Send")
                    .frame(width: 150, height: 50)
            })
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .clipShape(.capsule)
            .popover(isPresented: $sendClicked, content: {
                SendBitcoinView(isBitcoin: false)
                    .padding(10)
                    .presentationCompactAdaptation(.popover)
                    .presentationDetents([.height(270)])
            })
            
            Button(action: {
                receiveClicked = true
            }, label: {
                MenuCell(image: Image(systemName: "arrow.down.left"), text: "Receive")
                    .frame(width: 150, height: 50)
            })
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .clipShape(.capsule)
            .popover(isPresented: $receiveClicked, content: {
                ReceiveBitcoinView()
                    .padding(10)
                    .presentationCompactAdaptation(.popover)
                    .presentationDetents([.height(400)])
            })
            Spacer()
        }
    }
}

#Preview {
    LightningView(isListPeers: .constant(false))
}
