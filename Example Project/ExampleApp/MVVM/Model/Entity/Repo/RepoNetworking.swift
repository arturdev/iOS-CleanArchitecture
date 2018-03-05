//
//  RepoNetworking.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

protocol RepoNetworking {
    func fetchStargazes(of repo:String, completion handler:((Error?, [User]?)->Void)?)
    func fetchContributors(of repo:String, completion handler:((Error?, [User]?)->Void)?)
    func fetchWatchers(of repo:String, completion handler:((Error?, [User]?)->Void)?)
}
