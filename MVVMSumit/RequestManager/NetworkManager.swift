//
//  NetworkManager.swift
//  MVVMSumit
//
//  Created by Sam-Ranium on 14/10/22.
//

import Foundation
import SwiftyJSON
import UIKit


final class NetworManger {
    
    func employeeData(comp: @escaping (_ model: [EmployeeDataModel]?, _ isError: Bool) -> Void){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var url: URL? = nil
        
        url = URL(string: Domain.dev + APIEndpoint.Employee)!
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        //        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication)
        print("urlrequest : \(urlRequest)")
        
        let task = session.dataTask(with: urlRequest) { (data, response, error ) in
            if let response = response as? HTTPURLResponse, response.isResponseOK() {
                if let data = data {
                    //                    print("JSON vegeta = ",JSON(data))
                    let parseData = try? JSONDecoder().decode([EmployeeDataModel].self, from: data)
                    //                    print("parseData vegeta = ",parseData)
                    comp(parseData, false)
                }else{
                    comp(nil, true)
                }
            }else {
                comp(nil, true)
            }
            
        }
        task.resume()
    }
}
