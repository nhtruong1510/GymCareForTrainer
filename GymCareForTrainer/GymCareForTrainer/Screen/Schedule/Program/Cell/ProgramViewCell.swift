//
//  ProgramViewCell.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 27/02/2023.
//

import UIKit

class ProgramViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var cancelButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data: UserModel) {
        titleLabel.text = data.name
        iconImageView.loadImage(urlString: data.avatar, access: "user")
        cancelButton.isHidden = !(castToString(data.isCancelled) == "1")

    }
}
