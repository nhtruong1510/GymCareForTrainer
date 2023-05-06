//
//  NotificationViewCell.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import UIKit

class NotificationViewCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var alertImageView: UIImageView!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var statusLabel: UILabel!

    var showDetail: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillData(notify: NotifiObject) {
        dateLabel.text = formatDateString(dateString: castToString(notify.date_create),
                                          Constants.DATE_PARAM_FORMAT,
                                          Constants.DATE_FORMAT) 
        contentLabel.text = notify.content
        let isRead = castToInt(notify.is_read) == 1
        alertImageView.image = isRead ? #imageLiteral(resourceName: "ic_read") : #imageLiteral(resourceName: "ic_unread")
        if let status = TypeStatus(rawValue: castToInt(notify.status)) {
            statusView.backgroundColor = status.getViewColor()
            statusLabel.textColor = status.getTitleColor()
            statusLabel.text = status.text
        }
    }

    @IBAction private func showDetailButton(_ sender: Any) {
        if let showDetail = showDetail {
            showDetail()
        }
    }

}

