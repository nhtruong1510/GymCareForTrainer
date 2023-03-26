//
//  BabyManagerViewCell.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 01/01/2023.
//

import UIKit

class ManagementViewCell: UICollectionViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var noteView: UIView!
    @IBOutlet private weak var sumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(item: MenuItemModel) {
        iconImageView.image = item.icon
        titleLable.text = item.title
        noteView.isHidden = castToInt(item.badge) == 0
        if castToInt(item.badge) > 9 {
            sumLabel.text = "9+"
        } else {
            sumLabel.text = castToString(item.badge)
        }
    }

}

