//
//  NodeErrorView.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 08/11/23.
//

import SwiftUI

struct NodeErrorView: View {
    @State var alertPresented: Bool = true
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFill()
                .padding(.bottom, 30)
                .foregroundColor(.red)
            Text("Failed to Start LDK")
                .font(.title)
        }
    }
}

#Preview {
    NodeErrorView()
}
