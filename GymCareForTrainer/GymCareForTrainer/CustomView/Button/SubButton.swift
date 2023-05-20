//
//  SubButton.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 16/01/2023.
//

import UIKit

class SubButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }

    private func configUI() {
        layer.cornerRadius = frame.height / 2
        borderColor = UIColor.main_color
        backgroundColor = .white
        borderWidth = 1
        titleLabel?.font = UIFont.Bold(size: 18)
        setTitleColor(.main_color, for: .normal)
        updateLayerProperties()
    }

    private func updateLayerProperties() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }
}
