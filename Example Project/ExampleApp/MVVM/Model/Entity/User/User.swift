//
//  User.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import ObjectMapper

class User {
    var login: String?
    var avatarUrl: String?
    
    required init?(map: Map) {}
}

extension User: Mappable {    
    func mapping(map: Map) {
        login     <- map["login"]
        avatarUrl <- map["avatar_url"]
    }
}
