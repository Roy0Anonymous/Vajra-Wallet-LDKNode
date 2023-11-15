//
//  ContentView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 07/11/23.
//

import SwiftUI

struct MainView: View {
    @State private var isBitcoin: Bool = false
    @State private var isListPeers: Bool = true
    @State private var hasAppeared = false
    @State private var receiveAddress: String?
    @State private var ldkFailed = false
    @State private var recovery: Bool = false
    @State private var addPeer: Bool = false
    @State private var createChannel: Bool = false
    var ldkNode: LDKNodeManager = LDKNodeManager.shared
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Bitcoin or Lightning", selection: $isBitcoin) {
                    Text("Bitcoin").tag(true)
                    Text("Lightning").tag(false)
                }
                .pickerStyle(.segmented)
                Spacer()
                if isBitcoin {
                    BitcoinView()
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    recovery = true
                                } label: {
                                    Image(systemName: "key.fill")
                                }
                                .alert(ldkNode.getMnemonic(), isPresented: $recovery) {
                                    Button(action: {
                                        recovery = false
                                    }, label: {
                                        Text("Cancel")
                                    })
                                } message: {
                                    Text("Failed to Send Bitcoins")
                                }
                            }
                        })
                } else {
                    LightningView(isListPeers: $isListPeers)
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarLeading) {
                                if isListPeers {
                                    Button(action: {
                                        isListPeers = false
                                    }, label: {
                                        Image(systemName: "person.3.fill")
                                    })
                                } else {
                                    Button(action: {
                                        isListPeers = true
                                    }, label: {
                                        Image(systemName: "fibrechannel")
                                    })
                                }
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                HStack {
                                    Button(action: {
                                        addPeer = true
                                    }, label: {
                                        Image(systemName: "person.fill.badge.plus")
                                    })
                                    Button(action: {
                                        createChannel = true
                                    }, label: {
                                        Image(systemName: "person.line.dotted.person.fill")
                                    })
                                }
                            }
                        })
                        .popover(isPresented: $addPeer, content: {
                            AddPeerView()
                                .presentationCompactAdaptation(.sheet)
                                .presentationDetents([.height(180)])
                        })
                        .popover(isPresented: $createChannel, content: {
                            CreateChannelView()
                                .presentationCompactAdaptation(.sheet)
                                .presentationDetents([.height(240)])
                        })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        .onAppear() {
            isBitcoin = true
            if !hasAppeared {
//                print("has Appeared again hahahahaha")
                hasAppeared = true
//                Task(priority: .background, operation: {
//                    do {
//                        try await ldkManager.start()
//                    } catch {
//                        ldkFailed = true
//                    }
//                })
//                LDKManager.ldkQueue.async {
//                    receiveAddress = ldkManager.bdkManager.getAddress(addressIndex: .new)
//                }
//                LDKManager.ldkQueue.async {
//                    do {
//                        try ldkManager.start()
//                    } catch {
//                        ldkFailed = true
//                    }
//                }
            }
        }
        .fullScreenCover(isPresented: $ldkFailed, content: {
            NodeErrorView()
        })
    }
}

struct MenuCell: View {
    var image: Image
    var text: String
    var body: some View {
        HStack(spacing: 20) {
            image
                .font(.title2)
            Text(text)
                .font(.title2)
        }
    }
}

#Preview {
    MainView()
}
