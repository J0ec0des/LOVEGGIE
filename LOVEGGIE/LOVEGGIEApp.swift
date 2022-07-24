//
//  LOVEGGIEApp.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/16/22.
//

import SwiftUI
import Firebase

@main
struct LOVEGGIEApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
    init(){
        FirebaseApp.configure()
    }
}
