//
//  AuthenticationManager.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 19.07.2023.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
final class AuthenticationManager: ObservableObject {
    @Published var userSession: User?
    @Published var currentUser: UserModel?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Failed to Log in: \(error.localizedDescription)")
        }
    }
    
    func createUser(email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = UserModel(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch  {
           print(error.localizedDescription)
        }
    }
//
//    func getAuthenticatedUser() throws -> AuthDataModel {
//        guard let user = Auth.auth().currentUser else {
//            throw URLError(.badServerResponse)
//        }
//        return AuthDataModel(user: user)
//    }
    
    func fetchUser() async {
        
        //implement error handling, do-catch block
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: UserModel.self)
        
    }
    func deleteUser() {
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("ERROR: The user couldn't sign out. \(error.localizedDescription)")
        }
    }
}
