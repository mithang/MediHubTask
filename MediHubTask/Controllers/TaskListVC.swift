//
//  TaskListVC.swift
//  MediHubTask
//
//  Created by apple on 6/30/18.
//  Copyright © 2018 appledemoobj. All rights reserved.
//

import UIKit

class TaskListVC: UITableViewController {

    var listTasks: [Task] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MEDIHUB TASK"
        initData()
    }

    func initData(){
        listTasks.append(Task(title: "Học MVC Core", dueDate: Date(), type: .coding))
        listTasks.append(Task(title: "Xây admin cho web", dueDate: Date(), type: .houseWork))
        listTasks.append(Task(title: "Học Kotlin", dueDate: Date(), type: .vacationPlanning))
    }
    
    @IBAction func onCreateTask(_ sender: Any) {
        
    }
    
    func displayEmptyTableView(message:String){
        let lbinfo=UILabel()
        lbinfo.text=message
        lbinfo.textAlignment = .center
        lbinfo.numberOfLines=0
        lbinfo.font=UIFont(name: "HelveticaNeue-Bold", size: 20)
        tableView.backgroundView=lbinfo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if listTasks.count == 0{
            displayEmptyTableView(message: "Create some TODO tasks")
        }else{
            tableView.backgroundView=nil
        }
        return listTasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? ListTaskCell{
            let task = listTasks[indexPath.row]
            tableViewCell.configWith(task: task)
            cell=tableViewCell
        }
        //cell.textLabel?.text = listTasks[indexPath.row].title
        return cell
    }
    //Chú ý: Tip là sau khi design xong, lấy height và copy vào
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Đăng kí delegate để callback
        if let createTaskVC = segue.destination as? CreateTaskVC {
            createTaskVC.delegate = self
        }
        
        guard let selectedCell = sender as? UITableViewCell else{
            return
        }
        guard let selectedIndexPath = tableView.indexPath(for: selectedCell) else{
            return
        }
        guard let detailVC=segue.destination as? DetailVC else {
            return
        }
        detailVC.task=listTasks[selectedIndexPath.row]
    }
    

}

extension TaskListVC:TaskCreateDelegate{
    func didCreateNewTask(task: Task) {
        listTasks.append(task)
        tableView.reloadData()
    }
}
