//
//  UserModel.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 25.07.2023.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
            
        }
        return ""
    }
}

extension UserModel {
    static var MOCK_USER = UserModel(id: NSUUID().uuidString, fullName: "Kobe Bryant", email: "test@gmail.com")
}

struct IdealUser: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    let gardens: [String]
    let plant: [idealPlant]
    
}

struct idealPlant: Codable {
    let plantName: String
    let plantType: String
    let prunningTime: Date
}
