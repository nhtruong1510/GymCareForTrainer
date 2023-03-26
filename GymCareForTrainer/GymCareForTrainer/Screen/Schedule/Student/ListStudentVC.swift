//
//  ListStudentVC.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 28/02/2023.
//

import UIKit

class ListStudentVC: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    var titleValue: String?

    private var listSearchData: [RegionObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
//        titleLabel.text = titleValue
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        tableView.registerCells(from: .studentViewCell)
        tableView.tableFooterView = UIView()
    }

}

extension ListStudentVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3//listSearchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StudentViewCell.dequeueReuse(tableView: tableView)
//        cell.fillData(data: listSearchData[indexPath.row], seletedData: selectedData)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatRoomVC()
        self.nextScreen(ctrl: vc)
    }

}
