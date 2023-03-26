//
//  DateHeader.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/02/2023.
//

import UIKit
import JTAppleCalendar

class DateHeader: JTACMonthReusableView  {
    @IBOutlet weak var monthTitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!

    var onClickRight: (() -> Void)?
    var onClickLeft: (() -> Void)?

    @IBAction private func rightClick() {
        if let onClickRight = onClickRight {
            onClickRight()
        }
    }
    
    @IBAction private func leftClick() {
        if let onClickLeft = onClickLeft {
            onClickLeft()
        }
    }
}
