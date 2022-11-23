//
//  CommentData.swift
//  Skymie
//
//  Created by Nethan on 17/7/22.
//

import Foundation


struct CommentData: Identifiable {
    var id:String
    var username: String
    var comment: String
    var postId: String
    var pfp: String
    var verified: Bool
}
