//
//  HomeScreenView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 06.07.2023.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var manager: AuthenticationManager

    var body: some View {
        if let user = manager.currentUser {
            List {
                Section("Profile") {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight (.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                        }
                    }
                }


                Section("Settings") {
                    SettingsRowView(imageName: "gearshape", title: "Version", tintColor: .teal)
                }

                Section("Account") {
                    Button {
                        manager.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color.red)
                    }
                    
                    Button {
                        Task {
                            try await manager.resetPassword(email: manager.currentUser?.email ?? "No email")
                            print("Password Reset")
                        }
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Reset Password", tintColor: Color.red)
                    }
                }
            }
        }
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthenticationManager())
    }
}
