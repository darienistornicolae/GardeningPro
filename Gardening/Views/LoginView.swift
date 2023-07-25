//
//  LoginView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 06.07.2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var manager: AuthenticationManager
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.green, Color.blue], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea(.all)
                
                VStack() {
                    Text("Welcome!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom)
                    
                    InputView(text: $viewModel.emailInput, placeholder: "Email")
                        .autocapitalization(.none)
                    InputView(text: $viewModel.passwordInput, placeholder: "Password", isSecureField: true)
                    
                    Button {
                        Task {
                            try await manager.signIn(email: viewModel.emailInput ,password: viewModel.passwordInput)
                        }
                    } label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                    }
                    .padding()
                    
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 5) {
                            Text("Don't have an account?")
                            Text("Sign Up!")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
        .accentColor(Color.white)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !viewModel.emailInput.isEmpty &&
        viewModel.emailInput.contains("@") &&
        !viewModel.passwordInput.isEmpty &&
        viewModel.passwordInput.count > 5
    } 
}
