//
//  ViewController.swift
//  MVVMSumit
//
//  Created by Sam-Ranium on 14/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblEmployee: UITableView!
    
    var arrEmployeeData : [EmployeeDataModel] = [] {
        didSet {
            tblEmployee.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProjectData()
        tblEmployee.tableFooterView = UIView()
    }
    
}


//MARK: - UITableView Delegate & DataSource methods
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmployeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: EmployeeTVC = tableView.dequeueReusableCell(withIdentifier: "EmployeeTVC", for: indexPath as IndexPath) as? EmployeeTVC else {
            fatalError("AddressCell cell is not found")
        }
        
        let dict = arrEmployeeData[indexPath.row]
        cell.lblTitle.text = "id : \(dict.id!)" + ", " + "firstName : \(dict.firstName!)" + ", " + "lastName : \(dict.lastName!)" + ", " + "email : \(dict.email!)" + ", " + "dob : \(dict.dob!)" + ", " + "age : \(dict.age!)" + ", " + "address : \(dict.address!)" + ", " + "salary : \(dict.salary!)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

//MARK: - API callinng
extension ViewController {
    
    func getProjectData() {
        DispatchQueue.main.async {
            self.view.activityStartAnimating()
            self.view.isUserInteractionEnabled = false
        }
        
        EmployeeViewModel().getEmployeeDataList { isInternet, isError, data in
            DispatchQueue.main.async { [self] in
                self.view.activityStopAnimating()
                self.view.isUserInteractionEnabled = true
                if !isInternet {
                    self.showToast(message: "Check your internet connection.")
                } else if isError {
                    self.showAlert("Error", "Error")
                } else if let data = data {
                    self.arrEmployeeData = data
                    tblEmployee.reloadData()
                } else {
                    self.showAlert("Error", "Error")
                }
            }
        }
    }
    
}
