//
//  LoginViewModel.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 07.07.2023.
//

import Foundation
import Combine

@MainActor

final class LoginViewModel: ObservableObject {
    
    @Published var emailInput: String = ""
    @Published var passwordInput: String = ""
    
    private let authManager =  AuthenticationManager()
    
    func logIn() {
        guard !emailInput.isEmpty, !passwordInput.isEmpty else {
            //Do a validation
            print("No email, password or name")
            return
        }
        Task {
            do {
                let returnedUserData = try authManager.getAuthenticatedUser()
                print(returnedUserData)
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
       
    }
    
}
