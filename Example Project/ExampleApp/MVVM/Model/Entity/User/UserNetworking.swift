//
//  UserNetworking.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

protocol UserNetworking {
    func getPopularUsers(completion handler:((Error?, [User]?)->Void)?)
    func getRepos(of username:String, completion handler:((Error?, [Repo]?)->Void)?)
}
