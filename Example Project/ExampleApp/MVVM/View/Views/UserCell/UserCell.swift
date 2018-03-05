//
//  UserCell.swift
//  ExampleApp
//
//  Created by Artur Mkrtchyan on 3/1/18.
//  Copyright © 2018 Artur Mkrtchyan. All rights reserved.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: UserCellViewModelling? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            nameLabel.text = viewModel.usernameForUI
            avatarImageView.image = nil
            if let url = URL(string: viewModel.avatarUrl ?? "") {
                avatarImageView.kf.setImage(with: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImageView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
