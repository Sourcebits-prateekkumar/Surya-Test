//
//  Extension.swift
//  Surya-Test
//
//  Created by Prateek Kumar on 31/01/19.
//  Copyright © 2019 Sourcebits. All rights reserved.
//

import Foundation
import UIKit

let userListKey = "UserList"

extension UIImageView {

    func downloadImageFrom(url:String, contentMode: UIView.ContentMode, completionHandler: (() -> ())? = nil) {
        URLSession.shared.dataTask( with: URL(string:url)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async() {
                self.contentMode =  contentMode
                if let imageData = data { self.image = UIImage(data: imageData) }
                if completionHandler != nil {
                    completionHandler!()
                }
            }
        }).resume()
    }
}


extension String {

    // Validate Email
    var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
}


extension UserDefaults {

    /// Storing and Getting service configurations
    class func storeUsersList(userList: [User]) {

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userList) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userListKey)
        }
    }

    class func getUserList() -> [User]? {

        let defaults = UserDefaults.standard
        if let userData = defaults.object(forKey: userListKey) as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode([User].self, from: userData) {
                return user
            }
        }
        return nil
    }

}
