//
//  QuoteStore.swift
//  iQuotes
//
//  Created by Javier Valverde on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class QuoteStore {
    
    init() {
     
    }
    
    func createObject(forEntityName name: String) -> NSManagedObject? {
        if let entity = NSEntityDescription.entity(forEntityName: name, in: context) {
            return NSManagedObject(entity: entity, insertInto: context)
        }
        return nil
    }
    
    func addQuote(quote: Quote) {
        if let new_quote = createObject(forEntityName: "QuoteEntity") {
            new_quote.setValue(quote.quote, forKey: "quote")
            new_quote.setValue(quote.author, forKey: "author")
            new_quote.setValue(quote.length, forKey: "length")
            new_quote.setValue(quote.category, forKey: "category")
            new_quote.setValue(quote.title, forKey: "title")
            new_quote.setValue(quote.date, forKey: "date")
            new_quote.setValue(quote.id, forKey: "id")
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
    
    func deleteAllQuotes() {
        deleteAllForEntity(withName: "QuoteEntity")
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
    func updateQOTD(quote: Quote) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuoteEntity")
        let predicate = NSPredicate(format: "category == %@", quote.category)
        let updateRequest = NSBatchUpdateRequest(entityName: "QuoteEntity")
        fetchRequest.predicate = predicate
        updateRequest.predicate = predicate
        updateRequest.propertiesToUpdate = ["quote": quote.quote, "author": quote.author!, "length": quote.length, "date": quote.date!, "id": quote.id!]
        do {
            let results = try context.fetch(fetchRequest)
            if (results.count > 0) {
                try context.execute(updateRequest)
            } else {
                addQuote(quote: quote)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    func findAll(forEntityName entityName: String, withCategoryName categoryName: String) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "category == %@", categoryName)
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            print("Results: \(results.count)")
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
            print("Saved")
        }
    }
    
    func resetStore() {
        deleteAllQuotes()
    }
    
    var context: NSManagedObjectContext {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        }
    }
}
