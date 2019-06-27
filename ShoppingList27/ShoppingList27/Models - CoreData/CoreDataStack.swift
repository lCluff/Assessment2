//
//  CoreDataStack.swift
//  ShoppingList27
//
//  Created by Leah Cluff on 6/27/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

import Foundation
import CoreData

extension List {
    convenience init(name: String, due: Date? = nil, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.due = due
        self.isComplete = isComplete
    }
}

