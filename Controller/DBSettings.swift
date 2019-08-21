//
//  model.swift
//  ToDO
//
//  Created by Саша Руцман on 14.08.2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var toDoList: [ToDoItems] = []
fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate
fileprivate let context = appDelegate.persistentContainer.viewContext

func addItem(title: String, isComleted: Bool = false, details: String, iconId: Int) {
    
    let entity = NSEntityDescription.entity(forEntityName: "ToDoItems", in: context)
    let itemObject = NSManagedObject(entity: entity!, insertInto: context) as! ToDoItems
    itemObject.title = title
    itemObject.isCompleted = isComleted
    itemObject.details = details
    itemObject.iconId = Int64(iconId)
    
    do {
        toDoList.append(itemObject)
        try context.save()
    } catch {
        print(error.localizedDescription)
    }
    
}

func deleteItem(at index: Int) {
    
    let item = toDoList[index]

    context.delete(item)
    do {
        try context.save()
        toDoList.remove(at: index)
    } catch {
        print(error.localizedDescription)
    }
    
}


func loadData() {
    
    let fetchRequest: NSFetchRequest<ToDoItems> = ToDoItems.fetchRequest()
    do {
        toDoList = try context.fetch(fetchRequest)
    } catch {
        print(error.localizedDescription)
    }
    
}


