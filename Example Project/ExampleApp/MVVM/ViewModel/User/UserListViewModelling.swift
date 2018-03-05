//
//  UserListViewModelling.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserListViewModelling: BaseViewModelling {
    var userCellViewModels: BehaviorRelay<[UserCellViewModelling]> {get}    
    func fetchUsers()
}
