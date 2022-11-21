//
//  EmployeeViewModel.swift
//  MVVMSumit
//
//  Created by Sam-Ranium on 21/11/22.
//

import Foundation

struct EmployeeViewModel {
    
    func getEmployeeDataList(comp: @escaping (_ isInternet: Bool, _ isError: Bool, _ data: [EmployeeDataModel]?) -> Void) {
        if NetworkReachability.shared.isConnectedToInternet(){
            NetworManger().employeeData { model, isError in
                if isError{
                    comp(true, true, nil)
                } else {
                    if let model = model {
                        comp(true, false, model)
                    } else {
                        comp(true, true, nil)
                    }
                }
            }
        } else{
            comp(false, false, nil)
        }
    }
}
