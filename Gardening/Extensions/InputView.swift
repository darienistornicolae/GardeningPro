//
//  InputView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 25.07.2023.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .textFieldStyle(.plain)
                    .cornerRadius(8)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color(.systemGray6))
                    .textFieldStyle(.plain)
                    .cornerRadius(8)
            }
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), placeholder: "PlaceHolder", isSecureField: true)
    }
}
