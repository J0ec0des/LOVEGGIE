//
//  PostView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct PostView: View {
    
    @EnvironmentObject var posts: PostsViewModel
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    InfiniteScrollView(data: posts.documents, tab: { (post: Post) -> PostTabView in
                        return PostTabView(post: post)
                    }, link: { (post: Post) -> PostLinkView in
                        return PostLinkView(post: post)
                    }, onAppear: {
                        posts.loadPosts(amount: 2)
                    }, onRefresh: {
                        posts.reset()
                        posts.loadPosts(amount: 2)
                    }, onLoadData: { document in
                        posts.loadMorePostsIfNeeded(current: document, amount: 2)
                    })
                }
            }
        }
    }
}

struct PostTabView: View {
    var post: Post
    
    @State private var showimage: UIImage? = nil
    @State var showSheet: Bool = false
    // UI of each card
    var body: some View {
        VStack {
            VStack {
                Text(post.name)
                Text(post.price)
                ZStack {
                    if showimage != nil {
                        Image(uiImage: showimage!)
                            .resizable()
                            .frame(width:300, height: 300)
                        
                    }
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Text("")
                        .frame(width: 300, height: 300)
                    })
                    .sheet(isPresented: $showSheet, content: {
                        BuyView()
                    })
                        
                    
                }
            }
            .frame(maxWidth: .infinity, minHeight: 700)
            .background(Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255))
            Divider()
        }
        .onAppear {
            retrieveimage()
            print("called retrieved image func")
        }
    }
    
    
    func retrieveimage() {
        print("func called")
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("posts/\(post.uuid).jpg")
        print(post.uuid)
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                // display image
                
                if let image = UIImage(data: data!) {
                    //DispatchQueue.main.async {
                        showimage = image
                        print("updated image var")
                    //}
                }
            }
        }
    }
}

struct PostLinkView: View {
    var post: Post
    var body: some View {
        Text("\(post.name)")
        Text("\(post.price)")
        Button {
            
        } label: {
            Text("Buy")
        }
    }
}
