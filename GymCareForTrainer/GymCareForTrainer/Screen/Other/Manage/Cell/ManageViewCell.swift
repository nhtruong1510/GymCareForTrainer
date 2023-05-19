//
//  ManageViewCell.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 11/05/2023.
//

import UIKit

class ManageViewCell: UITableViewCell {
    
    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var warningView: UIView!
    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var showClassView: UIView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var widthClassViewConstraint: NSLayoutConstraint!

    var showClass: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillData(notify: NotifiObject, typeStatus: TypeStatus) {
        var statusText = ""
        switch typeStatus {
        case .ignore:
            statusText = "Từ chối"
        case .acceptUpdate, .acceptCreate:
            statusText = "Chấp nhận"
        case .create, .update:
            statusText = ""
        default: break
        }
        statusLabel.text = statusText
        let customer = notify.customer
        nameLabel.text = customer?.name
        dateLabel.text = notify.day
        classLabel.text = "Lớp " + castToString(notify.classModel?.name)
        avatarView.setupAvatarView(avatar: customer?.avatar, gender: customer?.gender)
        timeLabel.text = notify.time
        let date7after = Date().addingTimeInterval(3600*24*7)
        let endDate = notify.end_date?.formatToDate(Constants.DATE_PARAM_FORMAT) ?? Date()
        showClassView.isHidden = typeStatus != .acceptCreate
        widthClassViewConstraint.constant = typeStatus != .acceptCreate ? 0 : 150
        addressLabel.text = notify.address?.address

        if date7after > endDate && typeStatus != .ignore {
            let numberOfDays = Calendar.current.dateComponents([.day], from: Date(), to: endDate).day
            warningLabel.text = "Còn " + castToString(numberOfDays) + " ngày nữa là kết thúc"
            warningLabel.textColor = .systemOrange
            if Date() > endDate {
                var endText = ""
                switch typeStatus {
                case .create, .update:
                    endText = "Đã hết hạn"
                case .acceptCreate, .acceptUpdate:
                    endText = "Đã kết thúc"
                    showClassView.isHidden = true
                    widthClassViewConstraint.constant = 0
                default: break
                }
                warningLabel.text = endText
                warningLabel.textColor = .systemRed
            }
        }
        warningView.isHidden = date7after < endDate
    }
    
    @IBAction private func onClickShowClass() {
        showClass?()
    }
}
