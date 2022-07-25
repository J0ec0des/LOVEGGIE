//
//  FifthView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//
import Foundation
import SwiftUI


struct FourthView: View
{
    
    let chats = Chat.sampleChat
    
    @State private var query = ""
    
    var body: some View
    {
        NavigationView {
            List {
                ForEach(chats){ chat in
                    ChatRow(chat: chat)
                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $query)
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "square.and.pencil")
            })
        }
    }
}
    
struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView()
    }
}
