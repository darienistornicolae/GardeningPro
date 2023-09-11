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
    
    private let dataBase = Firestore.firestore()
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            do {
                await fetchUser()   
            }
        }
    }
    
    //MARK: User
    
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
            try await dataBase.collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch  {
           print("ERROR: User creation failed. \(error.localizedDescription)")
        }
    }
    
    func resetPassword(email: String) async throws {
       try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("ERROR: User is not signed in")
            return
        }
        
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            guard let data = snapshot.data() else {
                print("ERROR: User data not found")
                return
            }
            
            let user = try Firestore.Decoder().decode(UserModel.self, from: data)
            self.currentUser = user
        } catch {
            print("ERROR: Fetching user data failed - \(error)")
        }
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
    
    //MARK: Garden
    
    func createGarden(gardenName: String, plants: [Datum]) async throws {
        guard let currentUser = currentUser else {
            currentUser = nil
            return
        }
       
        let gardenId = UUID().uuidString
        
        do {
            let garden = Garden(gardenId: gardenId, gardenName: gardenName, plants: Welcome(data: plants, to: 0, perPage: 0, currentPage: 0, from: 0, lastPage: 0, total: 0))
            
            let jsonEncoder = JSONEncoder()
            let encodedGarden = try jsonEncoder.encode(garden)
            guard let gardenData = try JSONSerialization.jsonObject(with: encodedGarden, options: []) as? [String: Any] else {
                throw NSError(domain: "SerializationError", code: -1, userInfo: nil)
            }
            
            let userGardensRef = dataBase.collection("users").document(currentUser.id).collection("Gardens")
            try await userGardensRef.document(gardenId).setData(gardenData) // Save the garden data as a document in the subcollection
            
            self.currentGarden = garden
        } catch {
            print("ERROR: Garden creation failed. \(error.localizedDescription)")
        }
    }
    
    func fetchGarden(gardenId: String) async throws -> Garden? {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthenticationError", code: -1, userInfo: nil)
        }
        
        let userDocumentRef = dataBase.collection("users").document(uid)
        let gardenDocumentRef = userDocumentRef.collection("Gardens").document(gardenId)
        
        do {
            let gardenDocumentSnapshot = try await gardenDocumentRef.getDocument()
            
            if gardenDocumentSnapshot.exists, let data = gardenDocumentSnapshot.data() {
                let garden = try Firestore.Decoder().decode(Garden.self, from: data)
                return garden
            } else {
                return nil // Garden not found
            }
        } catch {
            throw error
        }
    }


    func addPlantToGarden(gardenId: String, plant: Datum) async throws {
        guard let currentUser = currentUser else {
            return
        }

        let userGardensRef = Firestore.firestore().collection("users").document(currentUser.id).collection("Gardens")
        let gardenDocument = userGardensRef.document(gardenId)

        // Fetch the current garden document
        let gardenDocumentSnapshot = try await gardenDocument.getDocument()

        // Decode it to a Garden if it exists, otherwise create a new one
        var garden: Garden
        if let existingGarden = try? gardenDocumentSnapshot.data(as: Garden.self) {
            garden = existingGarden
        } else {
            garden = Garden(gardenId: gardenId, gardenName: "New Garden", plants: Welcome(data: [], to: 0, perPage: 0, currentPage: 0, from: 0, lastPage: 0, total: 0))
        }

        // Add the new plant to the garden's plants
        garden.plants.data.append(plant)

        // Update the garden document with the new data
        try gardenDocument.setData(from: garden)

        // Fetch the updated garden
        self.currentGarden = garden
    }

}
