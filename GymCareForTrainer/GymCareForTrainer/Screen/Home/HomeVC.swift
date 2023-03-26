//
//  HomeVC.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 28/12/2022.
//

import UIKit
import SwiftUI

class HomeVC: BaseViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var avatarStudentView: AvatarView!
    @IBOutlet private weak var nameStudentLabel: UILabel!
    @IBOutlet private weak var nameSchoolLabel: UILabel!
    @IBOutlet private weak var totalNotiUnreadLabel: UILabel!
    @IBOutlet private weak var totalNotiUnreadView: UIView!

    private let viewModel = HomeViewModel()

//    var menuItems: [MenuItemModel] = []

    private lazy var bannerView = BannerView()
    private lazy var managementView = ManagementView()
    private lazy var notiView = NotiView()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavi()
    }

    private func getData() {
//        viewModel.callApiGetTop { [weak self] (response, msg) in
//            guard let `self` = self else { return }
//            if let response = response {
//                self.fillData(data: response)
//            } else {
//                AlertVC.show(msg: msg)
//            }
//        }
    }

    private func configUI() {
//        stackView.addArrangedSubview(bannerView)
//        bannerView.isHidden = true
        stackView.addArrangedSubview(notiView)
//        notiView.isHidden = true
        stackView.addArrangedSubview(managementView)
//        managementView.isHidden = true
        fillData(data: TopResponse())
    }

    private func setupNavi() {

    }

    private func fillData(data: TopResponse) {
//        if let banners = data.banners, banners.count > 0 {
//            bannerView.isHidden = false
//            bannerView.reloadData(datas: banners)
//        }
        managementView.isHidden = false
//        managementView.reloadData(items: items)
        managementView.onClick = { [weak self] id in
            guard let `self` = self else { return }
            self.nextScreen(ctrl: ContentProgramVC())
        }
        managementView.onClickMore = { [weak self] in
            guard let `self` = self else { return }
//            self.nextScreen(ctrl: ProgramVC())
        }
        notiView.isHidden = false
        notiView.onClickNoti = { [weak self] notiId in
            guard let `self` = self else  { return }
//            let vc = BookingVC()
//            self.nextScreen(ctrl: vc)
        }
        notiView.onClickMore = {
            let response: [String: Int] = ["type": Constants.notification]
            NotificationCenter.default.post(name: .GO_TAP_MESSAGE, object: nil, userInfo: response)
        }
        DispatchQueue.main.async {
            self.notiView.reloadData(notis: data.notifications ?? [])
        }
    }
}

// 3
struct HomeVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = HomeVC
    
    // 5
    func makeUIViewController(context: Context) -> HomeVC {
        HomeVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: HomeVC, context: Context) {
        
    }
}
