//
//  MessageData.swift
//  Skymie
//
//  Created by Nethan on 24/10/22.
//

import Foundation


import Foundation


struct MessageData: Identifiable {
    var id:String
    var username: String
    var message: String
    var commId: String
    var time: String
    var pfp: String
    var image: String
    var timestamp: Int
    var verified: Bool
    var subscription: String
}

