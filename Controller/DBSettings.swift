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
var completedTasks: [ToDoItems] = []
var notCompletedTasks: [ToDoItems] = []

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
        if itemObject.isCompleted == false {
            notCompletedTasks.append(itemObject)
        } else {
            completedTasks.append(itemObject)
        }
        try context.save()
    } catch {
        print(error.localizedDescription)
    }
    
}

func deleteItem(at section: Int, at index: Int) {
    var item: ToDoItems
    if section == 0 {
        item = notCompletedTasks[index]
        context.delete(item)
        do {
            try context.save()
            notCompletedTasks.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    } else {
        item = completedTasks[index]
        context.delete(item)
        do {
            try context.save()
            completedTasks.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    }

    
    
}


func loadData() {
    
    let fetchRequest: NSFetchRequest<ToDoItems> = ToDoItems.fetchRequest()
    do {
        toDoList = try context.fetch(fetchRequest)
        completedTasks = toDoList.filter() { $0.isCompleted == true }
        notCompletedTasks = toDoList.filter() { $0.isCompleted == false }
    } catch {
        print(error.localizedDescription)
    }
    
}


