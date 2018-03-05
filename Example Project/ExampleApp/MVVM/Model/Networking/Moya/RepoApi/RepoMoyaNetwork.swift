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
import RxSwift
import RxCocoa

struct RepoMoyaNetwork: RepoNetworking {
    
    fileprivate let provider = MoyaProvider<RepoMoyaApi>()
    
    func fetchStargazes(of repoFullName: String) -> Observable<[User]> {
        return fetch(.fetchStargazes(repoFullName))
    }
    
    func fetchContributors(of repoFullName: String) -> Observable<[User]> {
        return fetch(.fetchContributors(repoFullName))
    }
    
    func fetchWatchers(of repoFullName: String) -> Observable<[User]> {
        return fetch(.fetchWatchers(repoFullName))
    }
    
    private func fetch(_ req: RepoMoyaApi) -> Observable<[User]> {
        return provider.rx.request(req)
            .asObservable()
            .map({ Mapper<User>().mapArray(JSONObject: (try? $0.mapJSON()) ?? nil)! })
            .share()            
    }
}
