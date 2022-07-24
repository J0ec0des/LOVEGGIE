//
//  ContentView.swift
//  UBER_practice
//
//  Created by Hitomi Nakamura on 2022/07/13.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {
    var body: some View {
        TabView
        {
            FirstView().tabItem
            {
                Image(systemName: "heart")
            }
            
            SecondView().tabItem
            {
                Image(systemName: "magnifyingglass")
            }
            
            ThirdView().tabItem
            {
                Image("Tomato_Icon")
                    .renderingMode(.original)
                .resizable()
                .frame(width: 3.5, height: 3.5)
                .padding(.horizontal)
            }
            
            FourthView().tabItem
            {
                Image(systemName: "message")
            }
            
            FifthView().tabItem
            {
                Image(systemName: "clock").opacity(0.1)
            }
        }
        .accentColor(Color.black) // color of when the button was pressed
        .onAppear{
            UITabBar.appearance().backgroundColor = UIColor(white: 1, alpha: 0.4)
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

