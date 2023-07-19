//
//  AuthenticationManager.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 19.07.2023.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    
    func createUser(email: String, password: String) async throws -> AuthDataModel {
       let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
       let result = AuthDataModel(user: authDataResult.user)
        return result
    }
    
    func getAuthenticatedUser() throws -> AuthDataModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataModel(user: user)
    }
}
