//
//  UserListAPI.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 01/02/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import Foundation
import Moya

let appBaseURL = "http://surya-interview.appspot.com"

enum UserListAPI {

    case getUserList(email: String)

}

extension UserListAPI: TargetType {

    var baseURL: URL {
        return URL(string: appBaseURL)!
    }

    var path: String {
        switch self {
        case .getUserList:
            return "/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getUserList:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getUserList(let value):
            var params: [String: Any] = [:]
            params["emailId"] = value
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}


