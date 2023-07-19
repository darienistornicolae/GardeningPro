//
//  HomeScreenView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 06.07.2023.
//

import SwiftUI

struct HomeScreenView: View {
    private let manager = AuthenticationManager()
    @State private var showSignInView: Bool = false
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            let authUser = try?  manager.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true: false
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
