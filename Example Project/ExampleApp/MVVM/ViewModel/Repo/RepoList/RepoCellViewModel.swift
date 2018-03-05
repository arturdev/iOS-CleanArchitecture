//
//  RepoCellViewModel.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

class RepoCellViewModel: RepoCellViewModelling {
    var name: String?
    var fullName: String?
    var owner: User?
    var descr: String?
    var starsCount: String?
    var watchersCount: String?
    var forksCount: String?
    var openIssuesCount: String?
    
    fileprivate var repo: Repo {
        didSet {
            setRepo(repo)
        }
    }
    
    init(repo: Repo) {
        self.repo = repo
        setRepo(repo)
    }
    
    private func setRepo(_ repo: Repo) {
        name = repo.name
        fullName = repo.fullName
        owner = repo.owner
        descr = repo.descr
        
                
        starsCount = "\(repo.starsCount.withCommas())"
        watchersCount = "\(repo.watchersCount.withCommas())"
        forksCount = "\(repo.forksCount.withCommas())"
        openIssuesCount = "\(repo.openIssuesCount.withCommas())"
    }
}
