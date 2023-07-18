//
//  CreateGardenOnboardingView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import SwiftUI

struct CreateGardenOnboardingView: View {
    @State var gardenName: String = ""
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.green, Color.blue], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea(.all)
                VStack {
                    Text("Let's create your first garden")
                        .font(.title2)
                        .padding(.top, 30)
                    
                    TextField("Input your garden name", text: $gardenName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.top, 40)
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("Add Garden")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                }
                .navigationTitle("Hello, Nick!")
                .foregroundColor(.white)
                .padding(20)
            }
        }
    }
}

struct CreateGardenOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGardenOnboardingView()
    }
}
