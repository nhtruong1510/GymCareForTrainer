//
//  ManageVC.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 11/05/2023.
//

import UIKit

class ManageVC: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!

    private var listNotifi: [NotifiObject] = []
    private var listOriginNotifi: [NotifiObject] = []
    private let viewModel = NotificationViewModel()
    private let refreshControl = UIRefreshControl()
    private let userInfo = ServiceSettings.shared.userInfo
    private let listNotiHeader: [String] = ["Đơn mới", "Đơn đã duyệt", "Đơn đã huỷ"]
    private var selectedItem: Int = 0
    private var typeStatus: TypeStatus = .create

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getListNotify(showLoading: true)
    }
    
    private func configUI() {
        tableView.registerCells(from: .manageViewCell)
        collectionView.registerCells(from: .notiHeaderCell)
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        refreshControl.addTarget(self, action: #selector(getListNotify), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func getListNotify(showLoading: Bool) {
        viewModel.callApiGetSchedule(showLoading: showLoading, customerId: castToInt(userInfo?.id)) { [weak self] result, error in
            guard let `self` = self else { return }
            if let error = error {
                AlertVC.show(viewController: self, msg: error)
                return
            }
            if let notifications = result?.notifications {
                self.listNotifi = notifications.reversed()
                self.listOriginNotifi = self.listNotifi
                self.filterNoti()
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    private func getClasses(classId: Int?, timeId: Int?) {
        viewModel.getClasses(trainerId: castToInt(ServiceSettings.shared.userInfo?.id)) { data, msg in
            if let msg = msg {
                AlertVC.show(viewController: self, msg: msg)
            } else {
                if let data = data {
                    let classModel = data.first(where: {$0.datumClass?.id == classId})
                    let time = classModel?.time?.first(where: {$0.id == timeId})
                    let vc = ProgramVC()
                    vc.listSearchData = time?.customer ?? []
                    vc.titleValue = "Danh sách học viên"
                    vc.className = "Lớp: " + castToString(classModel?.datumClass?.name)
                    vc.time = "Thời gian: " + castToString(time?.date) + "/ " + castToString(time?.time)
                    vc.type = .customerClass
                    self.nextScreen(ctrl: vc)
                }
            }
        }
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
            listNotifi = listOriginNotifi.filter({ $0.status == TypeStatus.create.rawValue || $0.status == TypeStatus.update.rawValue})
            typeStatus = .create
        case 1:
            listNotifi = listOriginNotifi.filter({$0.status == TypeStatus.acceptUpdate.rawValue || $0.status == TypeStatus.acceptCreate.rawValue})
            typeStatus = .acceptCreate
        case 2:
            listNotifi = listOriginNotifi.filter({$0.status == TypeStatus.ignore.rawValue})
            typeStatus = .ignore
        default: break
        }
    }
}

extension ManageVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotifi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ManageViewCell.dequeueReuse(tableView: tableView)
        guard indexPath.row < listNotifi.count else { return cell }
        let notify = listNotifi[indexPath.row]
        cell.fillData(notify: notify, typeStatus: typeStatus)
        cell.showClass = { [unowned self] in
            self.getClasses(classId: notify.classModel?.id, timeId: notify.time_id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let notifyDetailVC = NotifiDetailVC()
//        notifyDetailVC.notify = listNotifi[indexPath.row]
//        self.nextScreen(ctrl: notifyDetailVC)
    }

}

extension ManageVC: UICollectionViewDelegate, UICollectionViewDataSource {
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
