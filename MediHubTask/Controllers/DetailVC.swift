//
//  DetailVC.swift
//  MediHubTask
//
//  Created by apple on 6/30/18.
//  Copyright © 2018 appledemoobj. All rights reserved.
//

import UIKit
import SwiftUI

class DetailVC: UIViewController {


    var task:Task?
    
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUIView()
//        ConfigTask()
        title = "Task Detail"
    }
    func loadUIView(){
        let controller = UIHostingController(rootView: DetailScreen())
        addChildViewController(controller)
        controller.view.frame = container.bounds
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}
