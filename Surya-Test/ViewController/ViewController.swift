//
//  ViewController.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 30/01/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!

    var viewModel: ViewModel!
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        viewModel = ViewModel()
        viewModelInputBindg()
        viewModelOutputBinding()
    }

    func viewModelInputBindg() {

        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailAddress)
            .disposed(by: disposeBag)

        postButton.rx.tap
            .bind(to: viewModel.postTapped)
            .disposed(by: disposeBag)

    }

    func viewModelOutputBinding() {
        viewModel.output.asObservable()
            .skip(1)
            .observeOn(MainScheduler.instance)
            .bind {
                self.presentUserListVc(users: $0)
            }
            .disposed(by: disposeBag)

        viewModel.errorMessage.asObservable()
            .skip(1)
            .observeOn(MainScheduler.instance)
            .bind(onNext: {
                self.displayError(errorMessage: $0)
            })
            .disposed(by: disposeBag)
    }

    func presentUserListVc(users: [User]) {

        let userListVc = storyboard?.instantiateViewController(withIdentifier: "\(UserListViewController.self)") as! UserListViewController
        let viewModel = UserListViewModel()
        viewModel.userList.value = users
        userListVc.viewModel = viewModel
        present(userListVc, animated: true)
    }

    func displayError(errorMessage: String) {

        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

