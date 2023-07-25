//
//  RootView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 25.07.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthenticationManager
   
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
                
            } else {
                LoginView()
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
