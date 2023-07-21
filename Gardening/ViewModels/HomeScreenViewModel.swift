//
//  HomeScreenViewModel.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 21.07.2023.
//

import Foundation

@MainActor
final class HomeScreenViewModel: ObservableObject {
    
    private let manager = AuthenticationManager()
    
    func logOut() throws {
        
       try manager.signOut()
    }
}
