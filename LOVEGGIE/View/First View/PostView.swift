//
//  PostView.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import CoreLocation

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
    @State private var distancenum: String = ""
    @State var showSheet: Bool = false
    @ObservedObject var locationManager = LocationManager.shared
    @State var location: CLLocation?
    // UI of each card
    var body: some View {
        if locationManager.userLocation == nil {
            LocationRequestView()
        } else {
            VStack {
                VStack {
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
                    Text(post.name)
//                        .font(.body)
//                        .fontWeight(.semibold)
                        .font(.system(size: 30, weight: .semibold, design: .default))
                        .frame(width: 200, height: 20, alignment: .leading)
                    Text("¥\(post.price)")
//                        .fontWeight(.medium)
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(width: 200, height: 15, alignment: .leading)
                    Text("\(distancenum)km away")
//                        .fontWeight(.medium)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .frame(width: 200, height: 20, alignment: .leading)
                   
                }
                .frame(maxWidth: .infinity, minHeight: 600)
                .background(Color(red: 255 / 255, green: 169 / 255, blue: 185 / 255))
                Divider()
            }
            .onAppear {
                location = locationManager.userLocation
                calcDistance()
                retrieveimage()
                print("called retrieved image func")
            }
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
    func calcDistance() {
        let location1 = CLLocation(latitude: post.latitude!, longitude: post.longitude!)
        let location2 = location
        let distance = location1.distance(from: location2!)/1000
        let roundDistance = round(distance * 10) / 10.0
        distancenum = String(format: "%.1f", roundDistance)
        print(distancenum)
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
