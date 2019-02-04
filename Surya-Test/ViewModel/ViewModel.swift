//
//  ViewModel.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 31/01/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import Foundation
import RxSwift


class ViewModel {

    let emailAddress = Variable("")
    let postTapped = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    let output = Variable<[User]>([])
    let errorMessage = Variable<String>("")
    let userListService: UserListService

    init(userListService: UserListService = UserListService()) {
        self.userListService = userListService
        postTapped.subscribe(onNext: {
            if self.emailAddress.value.isEmpty || !self.emailAddress.value.isValidEmail {
                self.errorMessage.value = "Please Enter Valid Email Address"
            } else {
                self.getUserList(emailId: self.emailAddress.value)
            }
        }).disposed(by: disposeBag)
    }

    func getUserList(emailId: String) {

        userListService.getUserList(email: emailId)
            .subscribe(onNext: { userList in
                self.output.value = userList
                UserDefaults.storeUsersList(userList: userList)
            }, onError: { error in
                 self.errorMessage.value = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
}
