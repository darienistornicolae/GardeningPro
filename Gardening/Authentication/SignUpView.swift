//
//  SignUpView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 06.07.2023.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    @State private var showCreateGardenOnboarding = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var user: AuthenticationManager
    
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    init(viewModel: @autoclosure @escaping () -> SignUpViewModel) {
        
        self._viewModel = StateObject(wrappedValue: viewModel())
       
    }
   
    var body: some View {
        NavigationView {
            ZStack {
                if colorScheme == .dark {
                    LinearGradient(colors: [Color.black, Color.green], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea(.all)
                } else {
                    LinearGradient(colors: [Color.blue, Color.green], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea(.all)
                }
                VStack(spacing: -5) {
                    Spacer()
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .foregroundColor(.white)
                    
                    InputView(text: $viewModel.email, placeholder: "Email")
                        .autocapitalization(.none)
                    
                    InputView(text: $viewModel.fullName, placeholder: "Input your full name")
                    
                    InputView(text: $viewModel.password, placeholder: "Password", isSecureField: true)
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $viewModel.confirmPassword, placeholder: "Confirm Password", isSecureField: true)
                        if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty {
                            if viewModel.password == viewModel.confirmPassword {
                                Image (systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .padding()
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .padding()
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    
                    
                    Button {
                        Task {
                            do {
                                try await user.createUser(email:viewModel.email, password:viewModel.password, fullName: viewModel.fullName)
                                self.isOnboardingCompleted = false
                                //dismiss()
                            } catch {
                                print("Error creating user: \(error.localizedDescription)")
                            }
                        }
                        //
                    } label: {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 5) {
                            Text("Already have an account?")
                            Text("Sign In!")
                                .fontWeight(.bold)
                        }
                        .accentColor(.white)
                    }
                    
                    
                }
                .padding()
            }
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}


extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty &&
        viewModel.email.contains("@") &&
        !viewModel.password.isEmpty &&
        viewModel.password.count > 5 &&
        viewModel.password == viewModel.confirmPassword &&
        !viewModel.fullName.isEmpty
    }
}
