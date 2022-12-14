//
//  AboutData.swift
//  Skymie
//
//  Created by Nethan on 8/10/22.
//

import Foundation



struct AboutData: Identifiable {
    var id:String
    var username: String
    var about: String
    var date: String
    var imageURL: String
    var reported: Bool
    var pfp: String
    var verified: Bool
    var subscription: String
    var timestamp: Int
}
