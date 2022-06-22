//
//  DetailVC.swift
//  MediHubTask
//
//  Created by apple on 6/30/18.
//  Copyright © 2018 appledemoobj. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbType: UILabel!
    var task:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigTask()
        title = "Task Detail"
    }
    func ConfigTask() {
        if let task=task{
            lbTitle.text = task.title
            lbType.text = task.type.rawValue
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat="dd/MM/yyyy"
            lbDate.text=dateFormatter.string(from:task.dueDate)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}
