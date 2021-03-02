//
//  Repository.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import Foundation

class Repository {
    public let fullName : String?
    public let htmlUrl : String?
    public let starCount : Int?
    public let authorImageURL: String?
    
    init(fullName: String?, htmlUrl: String?, starCount: Int?, authorImageURL: String?) {
        self.fullName = fullName
        self.htmlUrl = htmlUrl
        self.starCount = starCount
        self.authorImageURL = authorImageURL
    }
}
