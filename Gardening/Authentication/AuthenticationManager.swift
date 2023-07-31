//
//  AuthenticationManager.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 19.07.2023.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
final class AuthenticationManager: ObservableObject {
    @Published var userSession: User?
    @Published var currentUser: UserModel?
    @Published var currentGarden: Garden?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            do {
                try await fetchUser()
                try await fetchGarden()
            } catch {
                print("ERROR: Unable to fetch user. \(error.localizedDescription)")
            }
        }
    }
    
    func signIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await fetchUser()
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
            try await fetchUser()
        } catch  {
           print("ERROR: User creation failed. \(error.localizedDescription)")
        }
    }
    
    func resetPassword(email: String) async throws {
       try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func createGarden(gardenName: String, plants: [Datum]) async throws {
        guard let currentUser = currentUser else {
            currentUser = nil
            return
        }
        
        let gardenId = UUID().uuidString
        
        do {
            let garden = Garden(gardenId: gardenId, gardenName: gardenName, plants: Welcome(data: [Datum](), to: 0, perPage: 0, currentPage: 0, from: 0, lastPage: 0, total: 0) )
            
            let jsonEncoder = JSONEncoder()
            let encodedGarden = try jsonEncoder.encode(garden)
            guard let gardenData = try JSONSerialization.jsonObject(with: encodedGarden, options: []) as? [String: Any] else {
                throw NSError(domain: "SerializationError", code: -1, userInfo: nil)
            }
            
            let userGardensRef = Firestore.firestore().collection("users").document(currentUser.id).collection("Gardens")
            try await userGardensRef.addDocument(data: gardenData) // Save the garden data as a document in the subcollection
            
            self.currentGarden = garden
            try await fetchGarden()
        } catch {
            print("ERROR: Garden creation failed. \(error.localizedDescription)")
        }
    }


    
    func fetchGarden() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthenticationError", code: -1, userInfo: nil)
        }
        
        let userDocumentRef = Firestore.firestore().collection("users").document(uid)
        let gardenDocumentSnapshot = try await userDocumentRef.collection("Gardens").document("gardenDocumentId").getDocument()
        
        if gardenDocumentSnapshot.exists, let data = gardenDocumentSnapshot.data() {
            let garden = try Firestore.Decoder().decode(Garden.self, from: data)
            self.currentGarden = garden
        } else {
            throw NSError(domain: "DataNotFoundError", code: -1, userInfo: nil)
        }
    }


    
    func fetchUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        guard let data = snapshot.data() else { throw URLError(.badServerResponse) }
        let user = try Firestore.Decoder().decode(UserModel.self, from: data)
        self.currentUser = user
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