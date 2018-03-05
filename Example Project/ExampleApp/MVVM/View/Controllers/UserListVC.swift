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
        tableView.register(UserCell.self)
    }
    
    fileprivate func setupBindings() {        
        viewModel.userCellViewModels
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: UserCell.reuseIdentifier, cellType: UserCell.self)) {
            _, viewModel, cell in
            cell.viewModel = viewModel
        }
        .disposed(by: disposebag)
        
        tableView.rx.modelSelected(UserCellViewModel.self).subscribe { [weak self] (event) in
            guard let weakSelf = self else { return }
            
            let username =  event.element?.username ?? ""
            let vc = RepoListVC.instantiate(from: .Main)
            vc.viewModel = RepoListViewModel(username: username)
            weakSelf.navigationController?.pushViewController(vc, animated: true)
        }
        .disposed(by: disposebag)
        
        tableView.rx.itemSelected.subscribe { [weak self] (event) in
            guard let weakSelf = self, let indexPath = event.element else { return }
            weakSelf.tableView.deselectRow(at: indexPath, animated: true)
        }
        .disposed(by: disposebag)
        
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
        viewModel.fetchUsers()
    }
}
