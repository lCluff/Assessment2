//
//  ListController.swift
//  ShoppingList27
//
//  Created by Leah Cluff on 6/27/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

import Foundation
import CoreData

class ListController {
    
    static let sharedInstance = ListController()
    
    var fetchedResultsController: NSFetchedResultsController<List>
    
    init() {
        let request: NSFetchRequest<List> = List.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "due", ascending: false)]
        
        let resultsController: NSFetchedResultsController<List> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        fetchedResultsController = resultsController
        
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print("error performing fetch")
        }
    }
    
    //MARK: - Functions
    func create(listWithName name: String){
        let _ = List(name: name)
        saveToPersistentStore()
    }
    
    func update(list: List, item: String){
        list.name = item
        saveToPersistentStore()
    }
    
    func remove(list: List){
        list.managedObjectContext?.delete(list)
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(list: List) {
        list.isComplete = !list.isComplete
    }
    
    private func saveToPersistentStore() {
        
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved \(error.localizedDescription)")
        }
    }
}
