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
}
