//
//  Post.swift
//  LOVEGGIE
//
//  Created by Joe Kojima on 7/24/22.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ScrollableData {}

struct Post: Codable, ScrollableData {
    @ServerTimestamp var date: Timestamp?
    var name: String = ""
    var price: String = ""
    var uuid: String = ""
    var latitude: Double?
    var longitude: Double?
}
