//
//  UserMoyaApi.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import Moya

enum UserMoyaApi {
    case getPopularUsers()
    case getRepos(String)
}

extension UserMoyaApi: TargetType {
    var baseURL: URL {
        return URL(string: Config.apiBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .getPopularUsers():
            return "/search/users"
        case .getRepos(let username):
            return "/users/\(username)/repos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPopularUsers():
         return .requestParameters(parameters: ["q":"repos:>10 followers:>1000"], encoding: URLEncoding.queryString)
        case .getRepos(_):
            return .requestPlain
        }
    }
    
    var validate: Bool {
        return true
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
}



