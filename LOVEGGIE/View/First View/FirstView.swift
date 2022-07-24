//
//  FirstView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//

import Foundation
import SwiftUI

struct FirstView: View
{
    var body: some View
    {
        let posts = PostsViewModel()
       
            PostView()
                .environmentObject(posts)
        
    }
}
