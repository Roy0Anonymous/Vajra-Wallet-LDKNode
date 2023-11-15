//
//  BitcoinView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 07/11/23.
//

import SwiftUI

struct BitcoinView: View {
    @State private var sendClicked = false
    @State private var receiveClicked = false
    @State private var receiveAddress: String?
    var ldkNode: LDKNodeManager = LDKNodeManager.shared
    @State private var balance: UInt64 = 0
    var body: some View {
        VStack() {
            ScrollView {
                Text("Sats")
                    .font(.title)
                    .padding(.top, 200)
                Text("\(balance)")
                    .font(.title)
            }
            .refreshable {
                DispatchQueue.global(qos: .background).async {
                    ldkNode.syncWallet()
                    balance = ldkNode.balance()
                }
            }
            Spacer()
            customDualButtons
        }
        .onAppear {
            DispatchQueue.global(qos: .background).async {
                ldkNode.syncWallet()
                balance = ldkNode.balance()
            }
        }
    }
    
    var customDualButtons: some View {
        NavigationStack {
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
                    SendBitcoinView(isBitcoin: true)
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
                        .presentationDetents([.height(270)])
                })
                
                // To display in a new view
                
//                NavigationLink {
//                    ReceiveBitcoinView()
//                } label: {
//                    MenuCell(image: Image(systemName: "arrow.down.left"), text: "Receive")
//                        .frame(width: 150, height: 50)
//                }
//                .foregroundStyle(.white)
//                .background(Color.blue)
//                .clipShape(.capsule)
                Spacer()
            }
        }
    }
}

#Preview {
    BitcoinView()
}
