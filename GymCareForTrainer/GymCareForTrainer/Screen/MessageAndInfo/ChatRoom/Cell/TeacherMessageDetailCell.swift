//
//  TeacherMessageDetailCell.swift
//  GymCare
//
//

import UIKit

class TeacherMessageDetailCell: UITableViewCell {

    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var imageContantView: UIView!
    @IBOutlet private weak var attachmentImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!

    var viewImage: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        attachmentImageView.layer.masksToBounds = true
        attachmentImageView.layer.cornerRadius = 20
    }

    func fillData(data: MessageModel, teacher: UserModel?) {
        avatarView.setupAvatarView(avatar: teacher?.avatar, gender: teacher?.gender)
        contentLabel.text = data.content
        imageContantView.isHidden = castToInt(data.image?.count) == 0
        attachmentImageView.loadImage(urlString: data.image, access: "chat")
        let year = formatDateString(dateString: castToString(data.insDatetime),
                                    Constants.DATE_TIME_FORMAT,
                                    Constants.YEAR_STRING)
        let date = formatDateString(dateString: castToString(data.insDatetime),
                                    Constants.DATE_TIME_FORMAT,
                                    Constants.DATE_FORMAT)
        if year == Date().toString(Constants.YEAR_STRING) {
            timeLabel.text = formatDateString(dateString: castToString(data.insDatetime),
                                              Constants.DATE_TIME_FORMAT,
                                              Constants.DATE_TIME_FORMAT_4)
            if date == Date().toString() {
                timeLabel.text = formatDateString(dateString: castToString(data.insDatetime),
                                                  Constants.DATE_TIME_FORMAT,
                                                  Constants.HOUR_STRING)
            }
        } else {
            timeLabel.text = formatDateString(dateString: castToString(data.insDatetime),
                                              Constants.DATE_TIME_FORMAT,
                                              Constants.DATE_TIME_FORMAT_3)
        }
    }

    @IBAction private func onClickButton(_ sender: Any) {
        viewImage?()
    }

}
