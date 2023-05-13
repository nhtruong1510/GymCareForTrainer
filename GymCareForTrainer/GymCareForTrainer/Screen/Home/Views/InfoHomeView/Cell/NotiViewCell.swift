//
//  NotiViewCell.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 01/01/2023.
//

import UIKit

class NotiViewCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func fillData(data: Time) {
        dateLabel.text = "Lớp " + castToString(data.className)
        titleLabel.text = castToString(data.time) + ", " + castToString(data.date)
    }

}
