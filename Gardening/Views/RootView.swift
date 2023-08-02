//
//  RootView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 25.07.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthenticationManager
    @AppStorage("isSignUpCompleted") var isSignUpCompleted: Bool = false
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
    
    let trasition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                if !isOnboardingCompleted {
                    OnboardingView()
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))

                }  else {
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
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))

                }
            } else {
                LoginView()
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))

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
