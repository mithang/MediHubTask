//
//  Task.swift
//  MediHubTask
//
//  Created by apple on 6/30/18.
//  Copyright © 2018 appledemoobj. All rights reserved.
//

import Foundation
class Task{
    let title:String
    let dueDate:Date
    let type:TaskType
    init(title:String, dueDate:Date, type:TaskType) {
        self.title=title
        self.dueDate=dueDate
        self.type=type
    }
}
