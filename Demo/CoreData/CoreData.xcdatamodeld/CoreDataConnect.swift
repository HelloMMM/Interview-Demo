//
//  CoreDataConnect.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataConnect {
    
    static let shared = CoreDataConnect()
    
    let myContext: NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let myEntityName = "CollectionData"
    
    func insert(attributeInfo: [String: Any]) {
        
        let insetData = NSEntityDescription.insertNewObject(forEntityName: myEntityName, into: myContext)
        
        for (key,value) in attributeInfo {
            
            let t = insetData.entity.attributesByName[key]?.attributeType

            if t == .integer16AttributeType || t == .integer32AttributeType || t == .integer64AttributeType {

                insetData.setValue(value as! Int, forKey: key)
            } else if t == .doubleAttributeType || t == .floatAttributeType {

                insetData.setValue(value as! Double, forKey: key)
            } else if t == .booleanAttributeType {
                insetData.setValue((value as! String == "true" ? true : false), forKey: key)
            } else {
                insetData.setValue(value, forKey: key)
            }
        }
        
        do {
            try myContext.save()
            
        } catch {
            fatalError("\(error)")
        }
    }
    
    func retrieve(predicate: String?, sort: [[String:Bool]]?, limit: Int?) -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: myEntityName)
        
        // predicate
        if let myPredicate = predicate {
            request.predicate = NSPredicate(format: myPredicate)
        }
        
        // sort
        if let mySort = sort {
            var sortArr :[NSSortDescriptor] = []
            for sortCond in mySort {
                
                for (k, v) in sortCond {
                    
                    sortArr.append(NSSortDescriptor(key: k, ascending: v))
                }
            }
            
            request.sortDescriptors = sortArr
        }
        
        // limit
        if let limitNumber = limit {
            request.fetchLimit = limitNumber
        }

        do {
            return try myContext.fetch(request) as? [NSManagedObject]
            
        } catch {
            fatalError("\(error)")
        }
    }
    
    func someEntityExists(id: String) -> Bool {
        
        let request = NSFetchRequest<NSManagedObject>(entityName: myEntityName)
        request.predicate = NSPredicate(format: "id = %@", id)

        var results: [NSManagedObject] = []

        do {
            results = try myContext.fetch(request)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return results.count > 0
    }
    
    func delete(predicate: String?) {
        
        if let results = self.retrieve(predicate: predicate, sort: nil, limit: nil) {
            
            for result in results {
                
                myContext.delete(result)
            }
            
            do {
                try myContext.save()
                
            } catch {
                fatalError("\(error)")
            }
        }
    }
    
    func change(predicate: String, id1: Int, id2: Int) {
        
        let predicate1 = "id = '\(id1)'"
        let predicate2 = "id = '\(id2)'"
        let results1 = retrieve(predicate: predicate1, sort: nil, limit: nil)!
        let results2 = retrieve(predicate: predicate2, sort: nil, limit: nil)!
        
        for result in results1 {
            
            result.setValue(id2, forKey: "id")
        }
        
        for result in results2 {
            
            result.setValue(id1, forKey: "id")
        }
        
        do {
            try myContext.save()
        } catch {
            fatalError("\(error)")
        }
    }
}
