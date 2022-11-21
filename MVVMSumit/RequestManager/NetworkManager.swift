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


//
//enum Result<Value: Decodable> {
//    case success(Value)
//    case failure(Bool)
//}
//
//typealias Handler = (Result<Data>) -> Void
//
//enum NetworkError: Error {
//    case nullData
//}
//
//public enum Method {
//    case delete
//    case get
//    case head
//    case post
//    case put
//    case connect
//    case options
//    case trace
//    case patch
//    case other(method: String)
//}
//
//enum NetworkingError: String, LocalizedError {
//    case jsonError = "JSON error"
//    case other
//    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
//}
//
//extension Method {
//    public init(_ rawValue: String) {
//        let method = rawValue.uppercased()
//        switch method {
//        case "DELETE":
//            self = .delete
//        case "GET":
//            self = .get
//        case "HEAD":
//            self = .head
//        case "POST":
//            self = .post
//        case "PUT":
//            self = .put
//        case "CONNECT":
//            self = .connect
//        case "OPTIONS":
//            self = .options
//        case "TRACE":
//            self = .trace
//        case "PATCH":
//            self = .patch
//        default:
//            self = .other(method: method)
//        }
//    }
//}
//
//extension Method: CustomStringConvertible {
//    public var description: String {
//        switch self {
//        case .delete:            return "DELETE"
//        case .get:               return "GET"
//        case .head:              return "HEAD"
//        case .post:              return "POST"
//        case .put:               return "PUT"
//        case .connect:           return "CONNECT"
//        case .options:           return "OPTIONS"
//        case .trace:             return "TRACE"
//        case .patch:             return "PATCH"
//        case .other(let method): return method.uppercased()
//        }
//    }
//}
//
//protocol Requestable {}
//
//extension Requestable {
//
//    internal func request(method: Method, url: String, params: [NSString: Any]? = nil, callback: @escaping Handler) {
//
//        guard let url = URL(string: url) else {
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url,  completionHandler: { (data, response, error) in
//
//            DispatchQueue.main.async {
//
//                if let error = error {
//
//                    print(error.localizedDescription)
//
//                } else if let httpResponse = response as? HTTPURLResponse {
//
//                    if httpResponse.statusCode == 200 {
//
//                        let mappedModel = try? JSONDecoder().decode(EmployeeDataModel.self, from: data!)
//
//                        if mappedModel != nil {
//                            callback(.success(data!))
//                        } else {
//                            callback(.failure(true))
//                        }
//                    } else {
//
//                        callback(.failure(true))
//                    }
//                }
//            }
//        })
//        task.resume()
//    }
//}
