//
//  LaunchScreenView.swift
//  LOVEGGIE
//
//  Created by Reo Saito on 2022/07/23.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            background
            logo
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

private extension LaunchScreenView {
    
    var background: some View {
        Color("Launch-Screen-Background")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("Launch_Icon")
    }
    
}
