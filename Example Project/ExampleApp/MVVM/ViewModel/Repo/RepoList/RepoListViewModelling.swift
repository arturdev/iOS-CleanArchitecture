//
//  RepoViewModelling.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

protocol RepoListViewModelling: BaseViewModelling {
    var repoCellViewModels: [RepoCellViewModelling]? {get}
    func fetchRepos(completion handler:(()->Void)?)
}
