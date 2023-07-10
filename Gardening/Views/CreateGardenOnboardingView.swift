//
//  CreateGardenOnboardingView.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 10.07.2023.
//

import SwiftUI

struct CreateGardenOnboardingView: View {
    @State var gardenName: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.green, Color.blue], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea(.all)
                VStack {
                    Text("Let's add your first garden")
                        .font(.title2)
                    
                    TextField("Input your garden name", text: $gardenName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("Add Plant")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }

                }
                .navigationTitle("Hello, Nick!")
                .padding()
            }
        }
    }
}

struct CreateGardenOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGardenOnboardingView()
    }
}
