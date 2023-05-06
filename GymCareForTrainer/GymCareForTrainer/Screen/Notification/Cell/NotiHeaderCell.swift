//
//  NotiHeaderCell.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 06/05/2023.
//

import UIKit

class NotiHeaderCell: UICollectionViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(name: String, isSelected: Bool) {
        nameLabel.text = name
        nameLabel.textColor = isSelected ? .main_color : .black
        bottomView.isHidden = !isSelected
    }
}
