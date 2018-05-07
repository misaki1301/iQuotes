//
//  CategoryStore.swift
//  iQuotes
//
//  Created by Javier Valverde on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CategoryStore {
    
    init() {
        
    }
    
    func createObject(forEntityName name: String) -> NSManagedObject? {
        if let entity = NSEntityDescription.entity(forEntityName: name, in: context) {
            return NSManagedObject(entity: entity, insertInto: context)
        }
        return nil
    }
    
    func addCategory(name: String?) {
        if let category = createObject(forEntityName: "CategoryEntity") {
            category.setValue(name, forKey: "name")
            save()
        }
    }
    
    func deleteAllForEntity(withName entityName:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not delete. \(error). \(error.userInfo)")
        }
    }
    
    func deleteAllCategories() {
        deleteAllForEntity(withName: "CategoryEntity")
    }
    
    func findAll(forEntityName entityName: String, withPredicate predicate: NSPredicate? = nil) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let fetchPredicate = predicate {
            fetchRequest.predicate = fetchPredicate
        }
        do {
            let results = try context.fetch(fetchRequest)
            print("Results \(results.count)")
            return results as? [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return nil
    }
    
    func save() {
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
//            print("Saved")
        }
    }
    
    func resetStore() {
        deleteAllCategories()
    }
    
    var context: NSManagedObjectContext {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        }
    }
}
