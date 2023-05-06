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
    @IBOutlet private weak var collectionView: UICollectionView!

    private var listNotifi: [NotifiObject] = []
    private var listOriginNotifi: [NotifiObject] = []
    private let viewModel = NotificationViewModel()
    private let refreshControl = UIRefreshControl()
    private let userInfo = ServiceSettings.shared.userInfo
    private let listNotiHeader: [String] = ["Đơn mới", "Đơn đã duyệt", "Đơn đã huỷ"]
    private var selectedItem: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getListNotify()
    }
    
    private func configUI() {
        tableView.registerCells(from: .notificationViewCell)
        collectionView.registerCells(from: .notiHeaderCell)

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
                self.listOriginNotifi = self.listNotifi
//                self.filterNoti()
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
    
    private func reloadData() {
        collectionView.reloadData() {
            self.collectionView.scrollToItem(at: IndexPath(item: self.selectedItem, section: 0), at: .right, animated: true)
        }
        filterNoti()
        tableView.reloadData()
    }
    
    private func filterNoti() {
        switch selectedItem {
        case 0:
            listNotifi = listOriginNotifi.filter({$0.status == TypeStatus.viewOnly.rawValue || $0.status == TypeStatus.create.rawValue || $0.status == TypeStatus.update.rawValue})
        case 1:
            listNotifi = listOriginNotifi.filter({$0.status == TypeStatus.acceptUpdate.rawValue || $0.status == TypeStatus.acceptCreate.rawValue})
        case 2:
            listNotifi = listOriginNotifi.filter({$0.status == TypeStatus.ignore.rawValue})
        default: break
        }
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

extension NotificationVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = NotiHeaderCell.dequeueReuse(collectionView: collectionView, indexPath: indexPath)
        cell.fillData(name: listNotiHeader[indexPath.row], isSelected: selectedItem == indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listNotiHeader.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        reloadData()
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
