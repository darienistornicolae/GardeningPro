//
//  SignUpViewModel.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
//    private let authManager =  AuthenticationManager()
//    init() {
//
//    }
//
//    func createUser() async {
//        do {
//          try await authManager.createUser(email: email, password: password, fullName: fullName)
//        } catch {
//
//        }
//    }
    
//    func signUp() async throws {
//        guard !email.isEmpty, !password.isEmpty, fullName.isEmpty else {
//            //Do a validation
//            print("No email, password or name")
//            return
//        }
//        let returnedUserData = try await authManager.createUser(email: email, password: password)
//        print(returnedUserData)
//
//    }
}
