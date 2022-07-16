//
//  ContentView.swift
//  UBER_practice
//
//  Created by Hitomi Nakamura on 2022/07/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView
        {
            FirstView().tabItem
            {
                Image(systemName: "heart")
                Text("1st")
            }
            
            SecondView().tabItem
            {
                Image(systemName: "plus.app")
                Text("3rd")
            }
            
            ThirdView().tabItem
            {
                Image(systemName: "person.crop.circle")
                Text("4th")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FirstView: View
{
    var body: some View
    {
        ZStack
        {
            Color.pink.ignoresSafeArea(edges: .top)
            Text("First View")
        }
    }
}

struct SecondView: View
{
    var body: some View
    {
        ZStack
        {
            Color.red.ignoresSafeArea(edges: .top)
            Text("Second View")
        }
    }
}

struct ThirdView: View
{
    var body: some View
    {
        ZStack
        {
            Color.red.ignoresSafeArea(edges: .top)
            Text("Third View")
        }
    }
}

