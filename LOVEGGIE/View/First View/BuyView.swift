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
    var body: some View
    {
        ZStack
        {
            VStack {
                Text("Number of Items")
                    .font(.title3)
                DisclosureGroup("\(selectedNum)", isExpanded: $isExpanded) {
                    VStack {
                        ForEach(1...9, id: \.self) { num in
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
