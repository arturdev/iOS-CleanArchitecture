//
//  RepoViewModel.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RepoListViewModel: BaseViewModelling {
    var disposeBag = DisposeBag()
    
    var title: String? = "Repositories"
    
    lazy var userNetworking:UserNetworking = UserMoyaNetwork()
    var reachabilityService = try? DefaultReachabilityService()
    
    var repoCellViewModels: BehaviorRelay<[RepoCellViewModelling]> = BehaviorRelay(value: [])
    var error: BehaviorRelay<NetworkError?> = BehaviorRelay(value: nil)
    var showLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    fileprivate var repos: [Repo] = [] {
        didSet {
            var value = self.repoCellViewModels.value            
            value = repos.map({RepoCellViewModel(repo: $0)})
            self.repoCellViewModels.accept(value)            
        }
    }
    fileprivate var username: String
    
    init(username: String) {
        self.username = username
        
        reachabilityService?.reachability
            .skip(1)
            .filter({$0.reachable})
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (status) in
                guard let weakSelf = self else { return }
                if weakSelf.repos.isEmpty {
                    weakSelf.fetchRepos()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension RepoListViewModel: RepoListViewModelling {
    func fetchRepos() {
        self.showLoading.accept(true)
        userNetworking.getRepos(of: username).subscribe {[weak self] (event) in
            guard let weakSelf = self else { return }
            weakSelf.showLoading.accept(false)
            switch event {
            case .next(let repos):
                weakSelf.error.accept(nil)
                weakSelf.repos = repos
            case .error(let error):
                if let error = error as? NetworkError {
                    weakSelf.error.accept(error)
                }
                weakSelf.repos = []
            case .completed:                
                break;
            }
        }.disposed(by: disposeBag)
    }
}
