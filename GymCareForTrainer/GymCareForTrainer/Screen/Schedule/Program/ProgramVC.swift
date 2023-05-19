//
//  ProgramVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit

class ProgramVC: BaseViewController {

    enum TypeData {
        case customer
        case classes
        case datetime
        case customerClass
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var classView: UIView!
    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!

    var titleValue: String?
    var listIds: [(id: Int, isCancelled: Int)] = []
    var listSearchData: [UserModel] = []
    var listTimes: [TimeClass] = []
    var className: String?
    var time: String?
    var type = TypeData.customer
    private var viewModel = ProgramViewModel()
    private var listScheduleClass: [ScheduleClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        cutomNavi.title = titleValue
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        tableView.registerCells(from: .programViewCell)
        tableView.tableFooterView = UIView()
        switch type {
        case .customer:
            getSchedule()
        case .classes:
            getClasses()
        default: break
        }
        if let className = className, let time = time {
            classView.isHidden = false
            classLabel.text = className
            timeLabel.text = time
        }
    }
    
    func getSchedule() {
        for id in listIds {
            viewModel.getListStudent(timeId: id.id, isCancelled: id.isCancelled) { data, msg in
                if let msg = msg {
                    AlertVC.show(viewController: self, msg: msg)
                } else {
                    let dupplicateData = self.listSearchData.firstIndex(where: {$0.id == data?.id})
                    if let data = data, dupplicateData == nil {
                        self.listSearchData.append(data)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    private func getClasses() {
        viewModel.getClasses(trainerId: castToInt(ServiceSettings.shared.userInfo?.id)) { data, msg in
            if let msg = msg {
                AlertVC.show(viewController: self, msg: msg)
            } else {
                if let data = data {
                    self.listScheduleClass = data
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ProgramVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .customer, .customerClass:
            return listSearchData.count
        case .classes:
            return listScheduleClass.count
        default:
            return listTimes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProgramViewCell.dequeueReuse(tableView: tableView)
        switch type {
        case .customer:
            cell.fillData(data: listSearchData[indexPath.row])
        case .classes:
            cell.fillData(data: listScheduleClass[indexPath.row])
        case .datetime:
            cell.fillData(data: listTimes[indexPath.row])
        case .customerClass:
            cell.fillDataClass(data: listSearchData[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .customer, .customerClass:
            let vc = ListStudentVC()
//            self.nextScreen(ctrl: vc)
        case .classes:
            if castToInt(listScheduleClass[indexPath.row].time?.count) == 1 {
                let vc = ProgramVC()
                vc.listSearchData = listTimes[indexPath.row].customer ?? []
                vc.titleValue = "Danh sách lớp"
                vc.type = .customerClass
                nextScreen(ctrl: vc)
                return
            }
            let vc = ProgramVC()
            vc.listTimes = listScheduleClass[indexPath.row].time ?? []
            vc.type = .datetime
            vc.titleValue = listScheduleClass[indexPath.row].datumClass?.name
            nextScreen(ctrl: vc)
        case .datetime:
            let vc = ProgramVC()
            vc.listSearchData = listTimes[indexPath.row].customer ?? []
            vc.titleValue = "Danh sách học viên"
            vc.className = "Lớp: " + castToString(cutomNavi.title)
            vc.time = "Thời gian: " + castToString(listTimes[indexPath.row].date) + "/ " + castToString(listTimes[indexPath.row].time)
            vc.type = .customerClass
            nextScreen(ctrl: vc)
        }

    }

}
