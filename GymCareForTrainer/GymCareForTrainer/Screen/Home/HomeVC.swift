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
    private let userInfo = ServiceSettings.shared.userInfo

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
        viewModel.callApiGetNews { [weak self] (response, msg) in
            guard let `self` = self else { return }
            if let response = response {
                self.fillData(data: response)
            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
    }

    private func configUI() {
//        stackView.addArrangedSubview(bannerView)
//        bannerView.isHidden = true
        stackView.addArrangedSubview(notiView)
        notiView.isHidden = true
        stackView.addArrangedSubview(managementView)
        managementView.isHidden = true
        avatarStudentView.setupAvatarView(avatar: userInfo?.avatar, gender: userInfo?.gender)
        nameStudentLabel.text = userInfo?.name
    }

    private func setupNavi() {
        DispatchQueue.main.async {
            self.notiView.reloadData(notis: ServiceSettings.shared.listLastestSchedule)
        }
    }

    private func fillData(data: [NewsModel]) {
//        if data.count > 0 {
//            bannerView.isHidden = false
//            bannerView.reloadData(datas: banners)
//        }
        managementView.isHidden = false
        managementView.reloadData(items: data)
        managementView.onClick = { url in
            guard let url = URL(string: url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
//        managementView.onClickMore = { [weak self] in
//            guard let `self` = self else { return }
////            self.nextScreen(ctrl: ProgramVC())
//        }
//        notiView.isHidden = false
//        notiView.onClickNoti = { [weak self] notiId in
//            guard let `self` = self else  { return }
////            let vc = BookingVC()
////            self.nextScreen(ctrl: vc)
//        }
//        notiView.onClickMore = {
//            let response: [String: Int] = ["type": Constants.notification]
//            NotificationCenter.default.post(name: .GO_TAP_MESSAGE, object: nil, userInfo: response)
//        }
//        DispatchQueue.main.async {
//            self.notiView.reloadData(notis: data.notifications ?? [])
//        }
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
