//
//  RepoCell.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import UIKit
import Kingfisher

protocol RepoCellDelegate: class {
    func repoCell(didSelectWatchsCount sender: RepoCell)
    func repoCell(didSelectStarsCount sender: RepoCell)
    func repoCell(didSelectForksCount sender: RepoCell)
}

class RepoCell: UITableViewCell {

    @IBOutlet weak var ownerImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var forkButton: UIButton!
    
    weak var delegate: RepoCellDelegate?
    var viewModel: RepoCellViewModelling? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            ownerImageView.image = nil
            ownerImageView.kf.setImage(with: URL(string: viewModel.owner?.avatarUrl ?? ""))
            
            nameLabel.text = viewModel.name
            fullNameLabel.text = viewModel.fullName
            descrLabel.text = viewModel.descr
            
            watchButton.setTitle(viewModel.watchersCount, for: .normal)
            starButton.setTitle(viewModel.starsCount, for: .normal)
            forkButton.setTitle(viewModel.forksCount, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ownerImageView.layer.cornerRadius = 4
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func countButtonsTapped(_ sender: UIButton) {
        if sender == watchButton {
            self.delegate?.repoCell(didSelectWatchsCount: self)
        } else if sender == starButton {
            self.delegate?.repoCell(didSelectStarsCount: self)
        } else if sender == forkButton {
            self.delegate?.repoCell(didSelectForksCount: self)
        }
    }    
}
