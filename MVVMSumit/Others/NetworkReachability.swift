//
//  NetworkReachability.swift
//  Empeq
//
//  Created by Bharti Nagapure on 25/03/20.
//  Copyright © 2020 Ranium. All rights reserved.
//

import Foundation
import SystemConfiguration


public class NetworkReachability: NSObject, URLSessionDelegate, URLSessionDataDelegate{
    
    static let shared = NetworkReachability()
    //    static var isInternetAbove2MBPS = false
    
    override init() {
        
    }
    
    typealias speedTestCompletionHandler = (_ megabytesPerSecond: Double? , _ error: Error?) -> Void
    
    var speedTestCompletionBlock : speedTestCompletionHandler?
    
    var startTime: CFAbsoluteTime!
    var stopTime: CFAbsoluteTime!
    var bytesReceived: Int!
    
    
    
    func checkForSpeedTest() {
        
        testDownloadSpeedWithTimout(timeout: 5.0) { (speed, error) in
            print("Download Speed:", speed ?? "NA")
            print("Speed Test Error:", error ?? "NA")
        }
        
    }
    
    func testDownloadSpeedWithTimout(timeout: TimeInterval, withCompletionBlock: @escaping speedTestCompletionHandler) {
        
        guard let url = URL(string: "https://images.apple.com/v/imac-with-retina/a/images/overview/5k_image.jpg") else { return }
        
        startTime = CFAbsoluteTimeGetCurrent()
        stopTime = startTime
        bytesReceived = 0
        
        speedTestCompletionBlock = withCompletionBlock
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForResource = timeout
        let session = URLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
        session.dataTask(with: url).resume()
        
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        bytesReceived! += data.count
        stopTime = CFAbsoluteTimeGetCurrent()
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        let elapsed = stopTime - startTime
        
        if let aTempError = error as NSError?, aTempError.domain != NSURLErrorDomain && aTempError.code != NSURLErrorTimedOut && elapsed == 0  {
            speedTestCompletionBlock?(nil, error)
            return
        }
        
        let speed = elapsed != 0 ? Double(bytesReceived) / elapsed / 1024.0 / 1024.0 : -1
        speedTestCompletionBlock?(speed, nil)
        
    }
    
    public func isConnectedToInternet() ->  Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}

