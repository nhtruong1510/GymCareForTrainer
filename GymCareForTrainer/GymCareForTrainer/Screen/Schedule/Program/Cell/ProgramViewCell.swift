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
    @IBOutlet private weak var cancelLabel: UILabel!
    @IBOutlet private weak var cancelView: UIView!
    @IBOutlet private weak var widthConstrant: NSLayoutConstraint!

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
        iconImageView.borderColor = castToInt(data.gender) == 0 ? .color_46C0FF : .color_FFACCB
        cancelView.isHidden = !(castToString(data.isCancelled) == "1")
    }
    
    func fillData(data: ScheduleClass) {
        titleLabel.text = data.datumClass?.name
        iconImageView.loadImage(urlString: data.datumClass?.thump_img, access: "class")
        iconImageView.cornerRadius = 2
    }
    
    func fillData(data: TimeClass) {
        titleLabel.text = data.date
        cancelView.isHidden = false
        cancelLabel.text = castToString(data.time)
        cancelView.backgroundColor = .color_46C0FF
        widthConstrant.constant = 0
    }
    
    func fillDataClass(data: UserModel) {
        titleLabel.text = data.name
        iconImageView.loadImage(urlString: data.avatar, access: "user")
        iconImageView.borderColor = castToInt(data.gender) == 0 ? .color_46C0FF : .color_FFACCB

    }
}
