//
//  CreateWalletView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 08/11/23.
//

import SwiftUI

struct CreateWalletView: View {
    @State var walletCreated: Bool = false
    var ldkNode: LDKNodeManager = LDKNodeManager.shared
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    ldkNode.start()
                    walletCreated = true
                } label: {
                    Text("Create Wallet")
                        .foregroundColor(.white)
                }
                .frame(width: 150, height: 50, alignment: .center)
                .background(.orange)
                .cornerRadius(10)
                .navigationTitle(Text("Create Wallet"))
                .navigationDestination(isPresented: $walletCreated) {
                    if walletCreated {
                        MainView()
                    }
                }
                
//                NavigationLink {
//                    RecoverWalletView()
//                } label: {
//                    Text("Recover Wallet")
//                }

            }
        }
    }
}


#Preview {
    CreateWalletView()
}
