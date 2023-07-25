//
//  LoginViewModel.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 07.07.2023.
//

import Foundation
import Combine


final class LoginViewModel: ObservableObject {
    
    @Published var emailInput: String = ""
    @Published var passwordInput: String = ""
    
//    private let authManager =  AuthenticationManager()
//    
//    init() {
//        
//    }
//    func signIn() async {
//        do {
//            try await authManager.signIn(email: emailInput, password: passwordInput)
//        } catch {
//            
//        }
//    }
}
