//
//  RootView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 21.07.2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var showLogInView: Bool = false
    private let manager = AuthenticationManager()
    var body: some View {
        NavigationView {
            HomeScreenView(showLogInView: $showLogInView)
        }
        .fullScreenCover(isPresented: $showLogInView, content: {
            LoginView(viewModel: LoginViewModel())
        })
        .onAppear {
            let authUser = try? manager.getAuthenticatedUser()
            self.showLogInView = authUser == nil ? true : false
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
