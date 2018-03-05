//
//  UserListViewModelling.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import Foundation

protocol UserListViewModelling: BaseViewModelling {    
    var userCellViewModels: [UserCellViewModelling]? {get}
    func fetchUsers(completion handler:(()->Void)?)
}
