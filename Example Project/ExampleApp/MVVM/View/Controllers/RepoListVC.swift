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
    
    fileprivate lazy var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        setupBindings()
        errorHandling()
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
        viewModel.repoCellViewModels
            .bind(to: tableView.rx.items(cellIdentifier: RepoCell.reuseIdentifier, cellType: RepoCell.self)) { [weak self] (_, viewModel, cell) in
                guard let weakSelf = self else {return}
                cell.viewModel = viewModel
                cell.delegate = weakSelf
            }
            .disposed(by: disposebag)
        
        tableView.rx.modelSelected(RepoCellViewModel.self).subscribe { (event) in
            //guard let weakSelf = self else {return}
            //let selectedViewModel = event.element
            //TODO: navigate to repo detail's screen
            //TODO: try yourself!
        }.disposed(by: disposebag)
        
        tableView.rx.itemSelected.subscribe {[weak self] (event) in
            guard let weakSelf = self, let indexPath = event.element else {return}
            weakSelf.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposebag)
        
        viewModel.showLoading.subscribe { [weak self] (event) in
            guard let weakSelf = self else { return }
            if let show = event.element {
                if show {
                    weakSelf.tableView.separatorStyle = .none
                    weakSelf.activityIndicatorView.startAnimating()
                    weakSelf.tableView.backgroundView = weakSelf.activityIndicatorView
                } else {
                    weakSelf.tableView.separatorStyle = .singleLine
                    weakSelf.activityIndicatorView.stopAnimating()
                    weakSelf.tableView.backgroundView = nil
                }
            }
        }.disposed(by: disposebag)
    }
    
    fileprivate func errorHandling() {
        viewModel.error.asDriver().skip(1).drive(onNext: { [weak self] (error) in
            guard let weakSelf = self else { return }
            if let error = error {
                weakSelf.errorLabel.text = error.message ?? error.localizedDescription
                weakSelf.tableView.separatorStyle = .none
                weakSelf.tableView.backgroundView = weakSelf.errorLabel
            } else {
                weakSelf.tableView.separatorStyle = .singleLine
                weakSelf.tableView.backgroundView = nil
            }
        }).disposed(by: disposebag)
    }
    

    fileprivate func loadData() {
        viewModel.fetchRepos()                
    }
    
    //MARK: -
    func navigateToUsersList(type: UserListType, with repo: String) {
        let vc = UserListVC.instantiate(from: .Main)
        vc.viewModel = UserListViewModel(type: type, repo: repo)
        self.navigationController?.pushViewController(vc, animated: true)
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
