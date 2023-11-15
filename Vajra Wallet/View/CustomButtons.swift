//
//  CustomButtons.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import SwiftUI

struct CustomButtons: View {
    var label: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 50)
                .foregroundStyle(.accent)
            Text(label)
                .frame(height: 50)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    CustomButtons(label: "Demo")
}
