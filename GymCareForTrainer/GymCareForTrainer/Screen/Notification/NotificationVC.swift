//
//  NotificationVC.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import UIKit
import SwiftUI

class NotificationVC: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var listNotifi: [NotifiObject] = []
    private let viewModel = NotificationViewModel()
    private let refreshControl = UIRefreshControl()
    private let userInfo = ServiceSettings.shared.userInfo

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getListNotify()
    }
    
    private func configUI() {
        tableView.registerCells(from: .notificationViewCell)
        refreshControl.addTarget(self, action: #selector(getListNotify), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func getListNotify() {
        viewModel.callApiGetSchedule(customerId: castToInt(userInfo?.id)) { [weak self] result, error in
            guard let `self` = self else { return }
            if let error = error {
                AlertVC.show(viewController: self, msg: error)
                return
            }
            if let notifications = result?.notifications {
                self.listNotifi = notifications.reversed()
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    private func showDetail(noti: NotifiObject) {
        let notifyDetailVC = NotifiDetailVC()
        notifyDetailVC.notify = noti
        self.nextScreen(ctrl: notifyDetailVC)
    }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotifi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotificationViewCell.dequeueReuse(tableView: tableView)
        guard indexPath.row < listNotifi.count else { return cell }
        let notify = listNotifi[indexPath.row]
        cell.fillData(notify: notify)
        cell.showDetail = { [unowned self] in
            self.showDetail(noti: notify)
            self.listNotifi[indexPath.row].is_read = 1
            self.viewModel.callApiUpdateStatus(notiId: castToInt(self.listNotifi[indexPath.row].id)) {}
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }

}

// 3
struct NotificationVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = NotificationVC
    
    // 5
    func makeUIViewController(context: Context) -> NotificationVC {
        NotificationVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: NotificationVC, context: Context) {
        
    }
}
