//
//  MessageVC.swift
//  GymCare
//
//

import UIKit

class MessageVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MessageViewModel()
    private var topics: [Chat] = []
    private let refreshControl = UIRefreshControl()
    private var isRefresh: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getTopics(showLoading: true)
    }

    private func configUI() {
        tableView.registerCells(from: .messageViewCell)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func refresh(_ sender: AnyObject) {
        self.isRefresh = true
        self.viewModel.page = 1
        refreshControl.endRefreshing()
        self.getTopics(showLoading: false)
    }

    private func getTopics(showLoading: Bool) {
        viewModel.getTopics(showLoading: showLoading) { [weak self] data, msg in
            guard let `self` = self else { return }
            if let data = data?.chats {
                self.topics = data
                self.tableView.reloadData()
            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
    }

}

extension MessageVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessageViewCell.dequeueReuse(tableView: tableView)
        cell.fillData(data: topics[indexPath.row])
        cell.onClick = {
            let vc = ChatRoomVC()
            vc.idChat = self.topics[indexPath.row].id
            vc.customer = self.topics[indexPath.row].customer
            self.nextScreen(ctrl: vc)
            self.topics[indexPath.row].isReadTrainer = 1
            tableView.reloadData()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

}
