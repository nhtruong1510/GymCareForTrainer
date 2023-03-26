//
//  ContentProgramVC.swift
//  SchoolUp
//
//  Created by Truong Nguyen Huu on 16/02/2023.
//

import UIKit

class ContentProgramVC: BaseViewController {

    @IBOutlet private weak var extracurricularImageView: UIImageView!
    @IBOutlet private weak var expiredView: UIView!
    @IBOutlet private weak var registerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var deadlineLabel: UILabel!
    @IBOutlet private weak var scheduleLabel: UILabel!
    @IBOutlet private weak var registerLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var limitLabel: UILabel!
    @IBOutlet private var tickImageViews: [UIImageView]!
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var sendButton: PitDefaultButton!

    private let viewModel = ExtracurricularDetailViewModel()
    var id: Int?
    var onClickSendExtra: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        getInforExtracurricular()
    }

    private func fillData() {

    }

    private func getInforExtracurricular() {
//        viewModel.getExtracurricularDetail(id: castToString(id)) { data, msg in
//            if let data = data {
//                self.extracurricularDetail = data
//                self.fillData()
//            } else {
//                AlertVC.show(msg: msg)
//            }
//        }
    }

    @IBAction private func onClickBack() {
        self.backScreen()
    }
}
