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
import RxSwift
import RxCocoa

struct UserMoyaNetwork: UserNetworking {

    private let reachability = try? DefaultReachabilityService()
    fileprivate let provider = MoyaProvider<UserMoyaApi>()
    
    func getPopularUsers() -> Observable<[User]> {
        return provider.rx.request(.getPopularUsers())
            .asObservable()
            .map({
                let json = (try? $0.mapJSON()) as? [String:Any]
                let users = Mapper<User>().mapArray(JSONObject: json?["items"]) ?? []
                return users
            })
            .share()
    }
    
    func getRepos(of username: String) -> Observable<[Repo]> {
//        guard let reachability = reachability else { return Observable.of([])}
        return provider.rx.request(.getRepos(username))
            .asObservable()
            .map({ Mapper<Repo>().mapArray(JSONObject: try? $0.mapJSON()) ?? [] })
//            .retryOnBecomesReachable([], reachabilityService: reachability)
            .share()
    }        
}
