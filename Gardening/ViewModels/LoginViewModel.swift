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
    
    
    
}
