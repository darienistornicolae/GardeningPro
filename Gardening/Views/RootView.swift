//
//  RootView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 25.07.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthenticationManager
    
    let trasition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
                Group {
                    if authViewModel.userSession != nil {
                        TabView {
        
                            GardenView()
                                .tabItem {
                                    Image(systemName: "camera.macro")
                                    Text("Garden")
                                }
        
                            HomeScreenView()
                                .tabItem {
                                    Image(systemName: "person.fill")
                                    Text("Profile")
                                }
                        }
                        .transition(trasition)
        
                    } else {
                        LoginView()
                            .transition(trasition)
                    }
                }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(AuthenticationManager())
    }
}
