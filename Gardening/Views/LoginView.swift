//
//  LoginView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 06.07.2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    init(viewModel: LoginViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text: $viewModel.emailInput)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            SecureField("Password", text: $viewModel.passwordInput)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Button(action: {
                // Perform login action
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            // Add additional UI elements like forgot password, sign up, etc. here
            
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
