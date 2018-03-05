//
//  UserListVC.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import UIKit

class UserListVC: BaseVC {

    lazy var viewModel: UserListViewModelling = UserListViewModel()
    
    fileprivate var activityIndicatorView: UIActivityIndicatorView!

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.backgroundView = activityIndicatorView
        
        registerCells()
        setupBindings()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = viewModel.title
    }
    
    fileprivate func registerCells() {
        tableView.register(UserCell.self)
    }
    
    fileprivate func setupBindings() {
        viewModel.didError = { error in
            //TODO: show error
        }
    }
    
    fileprivate func loadData() {
        tableView.separatorStyle = .none
        activityIndicatorView.startAnimating()
        
        viewModel.fetchUsers { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.activityIndicatorView.stopAnimating()
            weakSelf.tableView.separatorStyle = .singleLine
            weakSelf.tableView.reloadData()
        }
    }
}

extension UserListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCellViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel.userCellViewModels?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedViewModel = viewModel.userCellViewModels?[indexPath.row]
        
        let vc = RepoListVC.instantiate(from: .Main)
        vc.viewModel = RepoListViewModel(username: selectedViewModel?.username ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
