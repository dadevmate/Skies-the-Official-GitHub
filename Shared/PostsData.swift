//
//  PostsData.swift
//  Skymie
//
//  Created by Nethan on 10/7/22.
//

import Foundation


struct PostsData: Identifiable {
    var id:String
    var username: String
    var post: String
    var date: String
    var imageURL: String
    var reported: Bool
    var pfp: String
    var verified: Bool
    var subscription: String
    var timestamp: Int
}
