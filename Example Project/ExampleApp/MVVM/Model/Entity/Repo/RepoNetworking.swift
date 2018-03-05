//
//  RepoNetworking.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxSwift

protocol RepoNetworking {
    func fetchStargazes(of repo:String) -> Observable<[User]>
    func fetchContributors(of repo:String) -> Observable<[User]>
    func fetchWatchers(of repo:String) -> Observable<[User]>
}
