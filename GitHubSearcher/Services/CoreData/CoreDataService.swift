//
//  CoreDataService.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import Foundation
import CoreData

final class CoreDataService {
    
    private let context = PersistentService.context
    private let repositoryResultsController: NSFetchedResultsController<ModelRepository>
    private let repositoryFetchRequest: NSFetchRequest<ModelRepository> = ModelRepository.fetchRequest()
    
    init() {
        repositoryFetchRequest.sortDescriptors = []
        repositoryResultsController = NSFetchedResultsController(
            fetchRequest: repositoryFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
    }
    
    public func getRepositories() -> [Repository] {
        do {
            try repositoryResultsController.performFetch()
        } catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        var repositories: [Repository] = []
        if let savedRepo = repositoryResultsController.fetchedObjects {
            for repo in savedRepo {
                repositories.append(repo.getRepository())
            }
        }
        return repositories
    }
    
    public func save(repository: Repository) {
        
        self.removeExcess()
        
        let toSave = ModelRepository(context: PersistentService.context)
        toSave.fullname = repository.fullName
        toSave.authorImageURL = repository.authorImageURL
        toSave.htmlUrl = repository.htmlUrl
        toSave.starCount = Int64(repository.starCount ?? 0)
        do {
            try context.save()
        } catch let error {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    private func removeExcess() {
        let repositories = self.getRepositories()
        guard let first = repositories.first, let fullname = first.fullName, repositories.count == AppConstants.maxNumberOfSavedRepositories else { return }
        
        repositoryFetchRequest.predicate = NSPredicate.init(format: "fullname = %@", fullname)
        if let result = try? context.fetch(repositoryFetchRequest) {
            for object in result {
                context.delete(object)
                do {
                    try context.save()
                } catch let error {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
}
