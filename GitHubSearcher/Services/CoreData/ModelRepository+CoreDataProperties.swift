//
//  ModelRepository+CoreDataProperties.swift
//  
//
//  Created by Roman Mishchenko on 02.03.2021.
//
//

import Foundation
import CoreData

extension ModelRepository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelRepository> {
        return NSFetchRequest<ModelRepository>(entityName: "ModelRepository")
    }

    @NSManaged public var htmlUrl: String?
    @NSManaged public var fullname: String?
    @NSManaged public var starCount: Int64
    @NSManaged public var authorImageURL: String?

    
    func getRepository() -> Repository {
        return Repository(fullName: self.fullname, htmlUrl: self.htmlUrl, starCount: Int(starCount), authorImageURL: self.authorImageURL)
    }
}
