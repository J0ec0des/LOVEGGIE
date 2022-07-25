//
//  BuyView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/25/22.
//

import Foundation
import SwiftUI

struct BuyView: View
{
    @State private var isExpanded = false
    @State private var selectedNum = 1
    var post: Post
    var body: some View
    {
        ZStack
        {
            VStack {
                ZStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                    
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.00001))
                
                
                
                VStack {
                    Text("Buy: \(post.name)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50, alignment: .leading)
                    Text(" ¥\(post.price)")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(width: 300, height: 30, alignment: .leading)
                }
                
                
                Divider()
                Spacer()
                
                Text("Number of Items")
                    .font(.title3)
                DisclosureGroup("\(selectedNum)", isExpanded: $isExpanded) {
                    VStack {
                        ForEach(1...8, id: \.self) { num in
                            Text("\(num)")
                                .font(.title3)
                                .padding(.all)
                                .onTapGesture {
                                    self.selectedNum = num
                                    withAnimation{
                                        self.isExpanded.toggle()
                                    }
                                }
                        }
                    }
                }
                .accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
                .padding(.all)
                .background(Color.blue)
                .cornerRadius(8)
                
                
                Divider()
                
                Button {
                    
                } label: {
                    Text("Buy")
                }
                .buttonStyle(.borderedProminent)
            }.padding(.all)
        }
    }
}
