//
//  UserListViewModel.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

enum UserListType: String {
    case popularUsers = "Popular Users"
    case stargazers   = "Stargazers"
    case contributors = "Contributors"
    case watchers  = "Watchers"
}

class UserListViewModel: BaseViewModelling {
    lazy var userNetworking: UserNetworking = UserMoyaNetwork()
    lazy var repoNetworking: RepoNetworking = RepoMoyaNetwork()
    
    var didError: ((Error) -> Void)?
    var userCellViewModels: [UserCellViewModelling]?
    
    fileprivate var type: UserListType
    fileprivate var repo: String?
    
    fileprivate var usersFetchedClosure: (()->Void)?
    
    fileprivate var users: [User]? {
        didSet {
            self.userCellViewModels = nil
            if let users = users {
                self.userCellViewModels = users.map({UserCellViewModel(user: $0)})
            }            
            self.usersFetchedClosure?()
        }
    }
    
    init(type: UserListType = .popularUsers, repo fullName: String? = nil) {
        //When type is not popularUsers then repo can't be nil
        assert((type == .popularUsers && fullName == nil) || (type != .popularUsers && fullName != nil), "")
        self.type = type
        self.repo = fullName
    }
}

extension UserListViewModel: UserListViewModelling {
    var title: String? {
        return self.type.rawValue
    }
    
    func fetchUsers(completion handler: (() -> Void)?) {
        self.usersFetchedClosure = handler
        switch type {
        case .popularUsers:
            userNetworking.getPopularUsers(completion: handleResponse)
        case .stargazers:
            repoNetworking.fetchStargazes(of: repo ?? "", completion: handleResponse)
        case .contributors:
            repoNetworking.fetchContributors(of: repo ?? "", completion: handleResponse)
        case .watchers:
            repoNetworking.fetchWatchers(of: repo ?? "", completion: handleResponse)
        }
    }

    fileprivate func handleResponse(_ error:Error?, _ user: [User]?) {
        if let error = error {
            self.usersFetchedClosure?()
            self.didError?(error)
            return
        }
        
        self.users = user
    }
}
