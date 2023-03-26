//
//  ScheduleViewCell.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit

class ScheduleViewCell: UITableViewCell {

    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: Time) {
        classLabel.text = data.className
        addressLabel.text = data.address
        timeLabel.text = data.time
    }
    
}
