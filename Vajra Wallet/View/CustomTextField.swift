//
//  CustomTextField.swift
//  Vajra Wallet
//
//  Created by Rahul Roy on 12/11/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var textContent: String
    var placeholder: String
    var body: some View {
        ZStack {
            TextField(placeholder, text: $textContent)
                .frame(height: 50)
                .background(.white)
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.accent, lineWidth: 2)
                .frame(height: 53)
        }
    }
}

#Preview {
    CustomTextField(textContent: .constant(""), placeholder: "Demo")
}
