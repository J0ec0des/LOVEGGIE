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
            }
            
            SecondView().tabItem
            {
                Image(systemName: "magnifyingglass")
            }
            
            ThirdView().tabItem
            {
                Image(systemName: "plus.app.fill")
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

struct FirstView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}

struct SecondView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}

struct ThirdView: View
{
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
            
            //image picker stack
            VStack {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                Button {
                    // show image previews
                    isPickerShowing = true
                } label: {
                    Text("Select a Photo")
                }
            }
             .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                //Image picker
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            }
        }
    }
}
    
struct FourthView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}
    
struct FifthView: View
{
    var body: some View
    {
        ZStack
        {
            Color.white.ignoresSafeArea(edges: .top)
        }
    }
}
