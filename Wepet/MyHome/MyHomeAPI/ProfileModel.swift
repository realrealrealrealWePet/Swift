//
//  ProfileModel.swift
//  Wepet
//
//  Created by jaegu park on 30/01/24.
//

import Foundation

struct UserInfoModel: Codable {
    var imageUrl: String
    var email: String
    var loginId: String
    var name: String
    var birth: String
    var gender: Int
}
