//
//  RepoMoyaNetwork.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct RepoMoyaNetwork: RepoNetworking {
    
    fileprivate let provider = MoyaProvider<RepoMoyaApi>()
    
    func fetchStargazes(of repoFullName: String, completion handler: ((Error?, [User]?) -> Void)?) {
        provider.request(.fetchStargazes(repoFullName)) { (result) in
            let users = Mapper<User>().mapArray(JSONObject: (try? result.value?.mapJSON()) ?? nil)
            handler?(result.error, users)
        }
    }
    
    func fetchContributors(of repoFullName: String, completion handler: ((Error?, [User]?) -> Void)?) {
        provider.request(.fetchContributors(repoFullName)) { (result) in
            let users = Mapper<User>().mapArray(JSONObject: (try? result.value?.mapJSON()) ?? nil)
            handler?(result.error, users)
        }
    }
    
    func fetchWatchers(of repoFullName: String, completion handler: ((Error?, [User]?) -> Void)?) {
        provider.request(.fetchWatchers(repoFullName)) { (result) in
            let users = Mapper<User>().mapArray(JSONObject: (try? result.value?.mapJSON()) ?? nil)
            handler?(result.error, users)
        }
    }    
}
