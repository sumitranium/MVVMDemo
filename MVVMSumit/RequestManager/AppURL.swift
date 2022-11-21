//
//  AppURL.swift
//  MVVMDemo
//
//  Created by Seifallah Selmi on 17/06/20.
//  Copyright © 2020 Seifallah Selmi All rights reserved.
//

import UIKit

struct Domain {
    static var dev = "https://hub.dummyapis.com/employee?"
}

extension Domain {
    static func baseUrl() -> String {
        print(Domain.dev)
        return Domain.dev
    }
}

struct APIEndpoint {
    static let Employee  = "noofRecords=10&idStarts=1001"
}


enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}

enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}

enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}

enum UploadType: String {
    case avatar
    case file
}



