//
//  APIClient.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 01/02/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class UserListService {

      private var provider: MoyaProvider<UserListAPI>

    init(provider: MoyaProvider<UserListAPI> = MoyaProvider<UserListAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])) {
        self.provider = provider
    }

     func getUserList(email: String) -> Observable<[User]> {
        return provider.rx
            .request(.getUserList(email: email))
            .map(parseJson)
            .asObservable()
            .catchError { error in
                return .error(error)
        }
    }

    func parseJson(response: Response) -> [User] {

        guard let json = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any],
            let data = try? JSONSerialization.data(withJSONObject: json!["items"]!, options: []),
            let users = try? JSONDecoder().decode([User].self, from: data) else { return [] }
        return users
    }
}
