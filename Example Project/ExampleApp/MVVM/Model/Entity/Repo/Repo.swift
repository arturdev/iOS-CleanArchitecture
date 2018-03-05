//
//  Repo.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import ObjectMapper

class Repo {
    var name: String?
    var fullName: String?
    var owner: User?
    var descr: String?
    var starsCount: Int = 0
    var watchersCount: Int = 0
    var forksCount: Int = 0
    var openIssuesCount: Int = 0
    
    required init?(map: Map) {}
}

extension Repo: Mappable {
    func mapping(map: Map) {
        name            <- map["name"]
        fullName        <- map["full_name"]
        owner           <- map["owner"]
        descr           <- map["description"]
        starsCount      <- map["stargazers_count"]
        watchersCount   <- map["watchers_count"]
        forksCount      <- map["forks_count"]
        openIssuesCount <- map["open_issues_count"]
    }
}
