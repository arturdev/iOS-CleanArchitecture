//
//  RepoViewModelling.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxCocoa

protocol RepoListViewModelling: BaseViewModelling {
    var repoCellViewModels: BehaviorRelay<[RepoCellViewModelling]> {get}
    func fetchRepos()
}
