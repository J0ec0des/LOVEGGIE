//
//  PostView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//

import SwiftUI

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

    // MARK: UI
    var body: some View {
        VStack {
            VStack {
                Text(post.name)
                Text(post.price)
            }
            .frame(maxWidth: .infinity, minHeight: 700)
            .background(Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255))
            Divider()
        }
    }
}

struct PostLinkView: View {
    var post: Post
    var body: some View {
        Text("\(post.name)")
        Text("\(post.price)")
    }
}
