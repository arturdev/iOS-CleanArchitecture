//
//  ReposVC.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import UIKit

class RepoListVC: BaseVC {
    
    var viewModel: RepoListViewModelling!
    
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
        tableView.register(RepoCell.self)
    }
    
    fileprivate func setupBindings() {
        viewModel.didError = { error in
            //TODO: show error
        }
    }
    
    fileprivate func loadData() {
        tableView.separatorStyle = .none
        activityIndicatorView.startAnimating()
        
        viewModel.fetchRepos { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.activityIndicatorView.stopAnimating()
            weakSelf.tableView.separatorStyle = .singleLine
            weakSelf.tableView.reloadData()
        }
    }
    
    func navigateToUsersList(type: UserListType, with repo: String) {
        let vc = UserListVC.instantiate(from: .Main)
        vc.viewModel = UserListViewModel(type: type, repo: repo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RepoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoCellViewModels?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel.repoCellViewModels?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //let selectedViewModel = self.viewModel.repoCellViewModels?[indexPath.row]
        //TODO: navigate to repo detail's screen
        //TODO: try yourself!
    }
}

extension RepoListVC: RepoCellDelegate {
    func repoCell(didSelectWatchsCount sender: RepoCell) {
        navigateToUsersList(type: .watchers, with: sender.viewModel?.fullName ?? "")
    }
    
    func repoCell(didSelectStarsCount sender: RepoCell) {
        navigateToUsersList(type: .stargazers, with: sender.viewModel?.fullName ?? "")
    }
    
    func repoCell(didSelectForksCount sender: RepoCell) {
        //TODO: open the list of forked repositories for sender.viewModel
        //TODO: try yourself!
    }
}
