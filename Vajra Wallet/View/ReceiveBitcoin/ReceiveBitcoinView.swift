//
//  ReceiveBitcoinView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 07/11/23.
//

import SwiftUI

struct ReceiveBitcoinView: View {
    var ldkNode: LDKNodeManager = LDKNodeManager.shared
    var viewModel: ReceiveBitcoinViewModel = ReceiveBitcoinViewModel()
    @State var address: String = ""
    var body: some View {
        VStack(spacing: 40) {
            if address.isEmpty {
                ProgressView()
            } else {
                Image(uiImage: UIImage(data: viewModel.generateQRCode(from: address)!)!)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.image = UIImage(data: viewModel.generateQRCode(from: address)!)!
                        }) {
                            Text("Copy to clipboard")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                Text("\(address)")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = address
                        }) {
                            Text("Copy to clipboard")
                            Image(systemName: "doc.on.doc")
                        }
                    }
//                    .frame(maxWidth: .infinity)
            }
        }
        .onAppear(perform: {
            DispatchQueue.global(qos: .userInitiated).async {
                address = ldkNode.getAddress()
            }
        })
        .padding(20)
    }
}

#Preview {
    ReceiveBitcoinView()
}
