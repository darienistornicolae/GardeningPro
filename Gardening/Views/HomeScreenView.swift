//
//  HomeScreenView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 06.07.2023.
//

import SwiftUI
import FirebaseAuth
struct HomeScreenView: View {
    
    @StateObject private var viewModel = HomeScreenViewModel()
    @Binding var showLogInView: Bool
    var body: some View {
        List {
            
            Button("Log Out") {
                Task {
                    do {
                        try viewModel.logOut()
                        showLogInView = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }

        }
        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(showLogInView: .constant(false))
    }
}
