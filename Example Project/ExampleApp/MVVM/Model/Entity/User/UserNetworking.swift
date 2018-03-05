//
//  UserNetworking.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxSwift

protocol UserNetworking {
    func getPopularUsers() -> Observable<[User]>
    func getRepos(of username:String) -> Observable<[Repo]>    
}
