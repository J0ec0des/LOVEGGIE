//
//  SplashScreenView.swift
//  LOVEGGIE
//
//  Created by Reo Saito on 2022/07/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                ZStack {
                    Color ("Launch-Screen-Background")
                        .edgesIgnoringSafeArea(.all)
                    Image ("Launch_Icon")
                    
                }
            }
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { withAnimation {
                    self.isActive = true
                }
                    
                }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
