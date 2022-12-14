//
//  UserData.swift
//  Skymie
//
//  Created by Nethan on 3/7/22.
//

import Foundation

struct UserData: Identifiable, Hashable {
    var id: String
    var username: String
    var person: String
    var password: String
    var bio: String
    var favourites: String
    var hobbies: String
    var mediaLink: String
    var pfp: String
    var verified: Bool
    var subscription: String
}
