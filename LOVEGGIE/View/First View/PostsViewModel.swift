//
//  PostsViewModel.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PostsViewModel: ObservableObject {
    @Published var documents: [DocumentSnapshot] = []
    
    let db = Firestore.firestore()
    
    func loadPosts(amount n: Int) {
        var query: Query
        if documents.count > 0 {
            query = db.collection("posts")
                .order(by: "date", descending: true)
                .limit(to: n)
                .start(afterDocument: documents.last!)
        } else {
            query = db.collection("posts")
                .order(by: "date", descending: true)
                .limit(to: n)
        }
        query.getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else { return }
            self.documents += documents
        }
    }
    
    func loadMorePostsIfNeeded(current: DocumentSnapshot, amount n: Int) {
        guard documents.count > 0 && current == documents.last! else { return }
        self.loadPosts(amount: n)
    }
    
    func reset() {
        documents = []
    }
}
