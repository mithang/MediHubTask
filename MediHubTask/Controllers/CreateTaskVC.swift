//
//  CreateTaskVC.swift
//  MediHubTask
//
//  Created by apple on 7/2/18.
//  Copyright © 2018 appledemoobj. All rights reserved.
//

import UIKit



//Chú ý: Khi kéo segue mà chọn show detail thì nó sẽ không có thanh navigation
class CreateTaskVC: UIViewController {
    
    @IBOutlet weak var navigationbar: UINavigationBar!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtTaskType: UITextField!
    
    var taskTypePickerView:UIPickerView?
    var dueDatePicker:UIDatePicker?
    let listTaskTypes:[TaskType]=[.coding,.vacationPlanning,.studying,.houseWork]
    
    var delegate: TaskCreateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationbar.delegate=self
        configTextFieds()
        configTapGestureRecognizer()
    }

    @IBAction func onCloseTask(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onCreateTask(_ sender: Any) {
        guard let taskTitle=txtTitle.text, taskTitle.count>0,
              let taskType=txtTaskType.text, taskType.count>0,
              let taskDate=txtDate.text, taskDate.count>0 else {
                displayError(errorTitle:"Error", errorMessage:"Missing required attributes.")
            return
        }
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="dd/MM/yyyy"
        guard let dueDate=dateFormatter.date(from: taskDate) else {
            displayError(errorTitle: "Invalid Date", errorMessage: "There was a problem with the date.")
            return
        }
        guard let taskTypetext=TaskType(rawValue: taskType) else {
            displayError(errorTitle: "Invalid Take Type", errorMessage: "There was a problem with the task type.")
            return
        }
        let newTask = Task(title: taskTitle, dueDate: dueDate, type: taskTypetext)
        delegate?.didCreateNewTask(task: newTask)
        dismiss(animated: true, completion: nil)
        
    }
    func displayError(errorTitle: String, errorMessage: String){
        let alert=UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction=UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
            
        }
        alert.addAction(okAction)
        present(alert,animated: true,completion: nil)
    }
    func configTapGestureRecognizer(){
        let tapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(CreateTaskVC.didDetectTap(recognizer:)))
        //Đăng kí sự kiện, khi tap trên màn hình thì đóng UIPicker, UIDate
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func didDetectTap(recognizer:UITapGestureRecognizer){
        view.endEditing(true)
    }
    func configTextFieds(){
        
        txtDate.delegate=self
        txtTitle.delegate=self
        txtTaskType.delegate=self
        
        taskTypePickerView=UIPickerView()
        txtTaskType?.inputView=taskTypePickerView
        taskTypePickerView?.delegate=self
        taskTypePickerView?.dataSource=self
        
        dueDatePicker=UIDatePicker()
        dueDatePicker?.datePickerMode = .date
        dueDatePicker?.addTarget(self, action: #selector(CreateTaskVC.dateSelected(datePicker:)), for: .valueChanged)
        txtDate.inputView=dueDatePicker
        
    }
    @objc func dateSelected(datePicker:UIDatePicker){
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="dd/MM/yyyy"
        let formattedDate=dateFormatter.string(from: datePicker.date)
        txtDate.text=formattedDate
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //Ẩn statusbar trên màn hình hiện tại
//    override var prefersStatusBarHidden: Bool{
//        return true
//    }
   
}
extension CreateTaskVC: UINavigationBarDelegate{
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
extension CreateTaskVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension CreateTaskVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listTaskTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtTaskType.text=listTaskTypes[row].rawValue
        view.endEditing(true)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let selectedTask=listTaskTypes[row]
        return selectedTask.rawValue
    }
}

