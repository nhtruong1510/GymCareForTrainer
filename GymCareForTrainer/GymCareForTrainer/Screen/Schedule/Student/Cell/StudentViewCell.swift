//
//  StudentViewCell.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 28/02/2023.
//

import UIKit

class StudentViewCell: UITableViewCell {

    @IBOutlet private weak var avatarView: AvatarView!
    override func awakeFromNib() {
        super.awakeFromNib()
        fillData(avatar: nil)
        // Initialization code
    }

    func fillData(avatar: String?) {
        avatarView.setupAvatarView(avatar: avatar, gender: 0)
    }
    
}
