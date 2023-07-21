//
//  SignUpViewModel.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let authManager =  AuthenticationManager()
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty, fullName.isEmpty else {
            //Do a validation
            print("No email, password or name")
            return
        }
        Task {
            do {
                let returnedUserData = try await authManager.createUser(email: email, password: password)
                print(returnedUserData)
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
       
    }
}
