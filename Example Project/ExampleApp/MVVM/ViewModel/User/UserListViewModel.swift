//
//  UserListViewModel.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum UserListType: String {
    case popularUsers = "Popular Users"
    case stargazers   = "Stargazers"
    case contributors = "Contributors"
    case watchers  = "Watchers"
}

class UserListViewModel: BaseViewModelling {
    let disposeBag = DisposeBag()
    lazy var userNetworking: UserNetworking = UserMoyaNetwork()
    lazy var repoNetworking: RepoNetworking = RepoMoyaNetwork()
    var reachabilityService = try? DefaultReachabilityService()
    
    var userCellViewModels: BehaviorRelay<[UserCellViewModelling]> = BehaviorRelay(value: [])
    var error: BehaviorRelay<NetworkError?> = BehaviorRelay(value: nil)
    var showLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)


    fileprivate var type: UserListType
    fileprivate var repo: String?
    
    fileprivate var users: [User] = [] {
        didSet {
            var value = self.userCellViewModels.value            
            value = users.map({UserCellViewModel(user: $0)})
            self.userCellViewModels.accept(value)
        }
    }
    
    init(type: UserListType = .popularUsers, repo fullName: String? = nil) {
        //When type is not popularUsers then repo can't be nil
        assert((type == .popularUsers && fullName == nil) || (type != .popularUsers && fullName != nil), "")
        self.type = type
        self.repo = fullName
        
        reachabilityService?.reachability
            .skip(1)
            .filter({$0.reachable})
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (status) in
                guard let weakSelf = self else { return }
                if weakSelf.users.isEmpty {
                    weakSelf.fetchUsers()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension UserListViewModel: UserListViewModelling {
    var title: String? {
        return self.type.rawValue
    }
    
    func fetchUsers() {
        self.showLoading.accept(true)
        var result: Observable<[User]>?
        switch type {
        case .popularUsers:
            result = userNetworking.getPopularUsers()
        case .stargazers:
            result = repoNetworking.fetchStargazes(of: repo ?? "")
        case .contributors:
            result = repoNetworking.fetchContributors(of: repo ?? "")
        case .watchers:
            result = repoNetworking.fetchWatchers(of: repo ?? "")
        }
        
        result?.subscribe { [weak self] (event) in
            guard let weakSelf = self else { return }
            weakSelf.showLoading.accept(false)
            
            switch event {
            case .next(let users):
                weakSelf.error.accept(nil)
                weakSelf.users = users
            case .error(let error):
                if let error = error as? NetworkError {
                    weakSelf.error.accept(error)
                }
                weakSelf.users = []
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}
