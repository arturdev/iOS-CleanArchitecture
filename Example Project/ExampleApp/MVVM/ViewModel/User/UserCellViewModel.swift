//
//  UserCellViewModel.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

class UserCellViewModel: UserCellViewModelling {
    
    var usernameForUI: String?
    var username: String?
    var avatarUrl: String?
    
    fileprivate var user: User {
        didSet {
            setUser(user)
        }
    }
    
    init(user: User) {
        self.user = user
        setUser(user)
    }
    
    private func setUser(_ user:User) {
        usernameForUI = "@\(user.login ?? "")"
        username = user.login
        avatarUrl = user.avatarUrl
    }
}
