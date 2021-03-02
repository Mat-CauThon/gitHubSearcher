//
//  STR.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import Foundation

struct STR {
    struct Search {
        static let history = "search.history".localized
        static let starsCount = "search.starsCount".localized
        
        struct Error {
            static let title = "search.error.title".localized
            static let description = "search.error.description".localized
            static let ok = "search.error.ok".localized
        }
    }
}

fileprivate extension String {
    var localized: String {
            return NSLocalizedString(self, comment: "")
    }
}
