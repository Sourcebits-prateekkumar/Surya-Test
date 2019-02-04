//
//  UserListViewController.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 31/01/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class UserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    //var users = Variable<[User]>([])
    var viewModel:UserListViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        getuserList()
    }

    func setupTableView() {

        viewModel.userList.asDriver()
            .distinctUntilChanged({ userlist1, userlist2 in
                return userlist1 == userlist2
            })
            .drive(tableView.rx.items(cellIdentifier: "\(UserTableViewCell.self)")) { indexpath, user, cell in
                if let userCell = cell as? UserTableViewCell {
                    userCell.nameLabel.text = user.firstName + user.lastName
                    userCell.emailLabel.text = user.emailId
                    userCell.profileImageView.image = nil
                    userCell.profileImageView.downloadImageFrom(url: user.imageUrl, contentMode: .scaleAspectFit)
                }
            }.disposed(by: disposeBag)
    }

    func getuserList() {
        
        viewModel.getUserList(emailId: "pk@gmail.com")
    }

}
