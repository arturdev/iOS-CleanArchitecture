//
//  RepoViewModel.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

class RepoListViewModel: BaseViewModelling {
    var title: String? = "Repositories"
    
    var userNetworking:UserNetworking = UserMoyaNetwork()
    
    var didError: ((Error) -> Void)?
    var repoCellViewModels: [RepoCellViewModelling]?
    
    fileprivate var reposFetchedClosure: (()->Void)?

    fileprivate var repos: [Repo]? {
        didSet {
            self.repoCellViewModels = nil
            if let repos = repos {
                self.repoCellViewModels = repos.map({RepoCellViewModel(repo: $0)})
            }
            self.reposFetchedClosure?()
        }
    }
    fileprivate var username: String
    
    init(username: String) {
        self.username = username
    }
}

extension RepoListViewModel: RepoListViewModelling {
    func fetchRepos(completion handler: (() -> Void)?) {
        reposFetchedClosure = handler
        userNetworking.getRepos(of: username) { [weak self] (error, repos) in
            guard let weakSelf = self else {
                return
            }
            if let error = error {
                handler?()
                weakSelf.didError?(error)
                return
            }
            
            self?.repos = repos
        }
    }
}
