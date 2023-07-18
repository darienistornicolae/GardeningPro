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
        ZStack {
            LinearGradient(colors: [Color.green, Color.blue], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Spacer()
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                TextField("Email", text: $viewModel.emailInput)
                    .padding()
                    .background(Color(.systemGray6))
                    .textFieldStyle(.plain)
                    .cornerRadius(8)
                
                SecureField("Password", text: $viewModel.passwordInput)
                    .padding()
                    .background(Color(.systemGray6))
                    .textFieldStyle(.plain)
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
                Spacer()
                
                NavigationLink {
                    SignUpView(viewModel: SignUpViewModel())
                } label: {
                    Text("You don't have an accoun? Create one here.")
                        .foregroundColor(.white)
                    
                }
                
                
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
