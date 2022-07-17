//
//  ContentView.swift
//  UBER_practice
//
//  Created by Hitomi Nakamura on 2022/07/13.
//

import SwiftUI

struct ContentView: View
{
    var body: some View
    {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home:View
{
    @State var index = 0
    var body: some View
    {
        ZStack
        {
            VStack{
                Spacer()
                
                HStack(spacing: 0){
                    
                    Button(action: {
                        
                        self.index = 0
                        
                    }) {
                        
                        Image(systemName:"heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        self.index = 1
                        
                    }) {
                        
                        Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        self.index = 2
                        
                    }) {
                        
                        Image(systemName: "plus.app.fill")
                            .renderingMode(.original)
                        .resizable()
                        .frame(width: 40, height: 25)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        self.index = 3
                        
                    }) {
                        
                        Image(systemName: "message")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        self.index = 4
                        
                    }) {
                        
                        Image(systemName: "clock")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 4 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom,25)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}
