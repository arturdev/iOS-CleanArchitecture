//
//  RepoMoyaApi.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import Moya

enum RepoMoyaApi {
    case fetchStargazes(String)
    case fetchContributors(String)
    case fetchWatchers(String)
}

extension RepoMoyaApi: TargetType {
    var baseURL: URL {
        return URL(string: Config.apiBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchStargazes(let repo):
            return "repos/\(repo)/stargazers"
        case .fetchWatchers(let repo):
            return "repos/\(repo)/watchers"
        case .fetchContributors(let repo):
            return "repos/\(repo)/contributors"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"Application/json"]
    }        
}
