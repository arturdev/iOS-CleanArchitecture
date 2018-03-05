//
//  UserMoyaNetwork.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

struct UserMoyaNetwork: UserNetworking {
    fileprivate let provider = MoyaProvider<UserMoyaApi>()
    
    func getPopularUsers(completion handler: ((Error?, [User]?)->Void)?) {
        provider.request(.getPopularUsers()) { (result) in
            let json = (try? result.value?.mapJSON()) as? [String:Any]
            let users = Mapper<User>().mapArray(JSONObject: json?["items"])
            handler?(result.error, users)            
        }
    }
    
    func getRepos(of username: String, completion handler: ((Error?, [Repo]?)->Void)?) {
        provider.request(.getRepos(username)) { (result) in
            let repos = Mapper<Repo>().mapArray(JSONObject: (try? result.value?.mapJSON()) ?? nil)
            handler?(result.error, repos)
        }
    }
}
