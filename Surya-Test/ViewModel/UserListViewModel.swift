//
//  UserListViewModel.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 01/02/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import Foundation
import RxSwift

class  UserListViewModel {

    var userListService: UserListService
    var userList = Variable<[User]>([])
    var errorMessage = Variable<String>("")
    let disposeBag = DisposeBag()

    init(userListService: UserListService = UserListService()) {
        self.userListService = userListService
    }

    func getUserList(emailId: String) {

        userListService.getUserList(email: emailId)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                    self.userList.value = result
                }, onError: { error in
                    self.errorMessage.value = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
}
