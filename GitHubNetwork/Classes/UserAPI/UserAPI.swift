//
//  UserAPI.swift
//  GithubAPI
//
//  Created by Serhii Londar on 1/6/18.
//

import Foundation
import BaseAPI

public class UserAPI: GithubAPI {
    public func getUser(completion: @escaping(UserResponse?, Error?) -> Void) {
        self.gh_get(path: "/user", completion: completion)
    }
    
    public func getUser(username: String, completion: @escaping(OtherUserResponse?, Error?) -> Void) {
        let encodedUsername = username.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
        self.gh_get(path: "/users/\(encodedUsername)", completion: completion)
    }
    
}
