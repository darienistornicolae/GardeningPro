//
//  GardeningApp.swift
//  Gardening
//
//  Created by Darie-Nistor Nicolae on 06.07.2023.
//

import SwiftUI
//import RevenueCat
import Firebase
//import GoogleMobileAds



@main
struct GardeningApp: App {
    @StateObject var authViewModel = AuthenticationManager()
    init() {
        FirebaseApp.configure()
        
//        GADMobileAds.sharedInstance().start(completionHandler: nil)
//        Purchases.logLevel = .debug
//        Purchases.configure(withAPIKey: "appl_jWKLVAnpkjXeJobUQlyOrzLRkkn")
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authViewModel)
            
        }
    }
}
