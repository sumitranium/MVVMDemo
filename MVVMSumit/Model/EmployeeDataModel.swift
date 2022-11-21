//
//  EmployeeDataModel.swift
//
//  Created by Sam-Ranium on 06/11/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EmployeeDataModel: NSCoding,Decodable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let email = "email"
        static let id = "id"
        static let address = "address"
        static let lastName = "lastName"
        static let age = "age"
        static let firstName = "firstName"
        static let salary = "salary"
        static let imageUrl = "imageUrl"
        static let contactNumber = "contactNumber"
        static let dob = "dob"
    }
    
    // MARK: Properties
    public var email: String?
    public var id: Int?
    public var address: String?
    public var lastName: String?
    public var age: Int?
    public var firstName: String?
    public var salary: Int?
    public var imageUrl: String?
    public var contactNumber: String?
    public var dob: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        email = json[SerializationKeys.email].string
        id = json[SerializationKeys.id].int
        address = json[SerializationKeys.address].string
        lastName = json[SerializationKeys.lastName].string
        age = json[SerializationKeys.age].int
        firstName = json[SerializationKeys.firstName].string
        salary = json[SerializationKeys.salary].int
        imageUrl = json[SerializationKeys.imageUrl].string
        contactNumber = json[SerializationKeys.contactNumber].string
        dob = json[SerializationKeys.dob].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = email { dictionary[SerializationKeys.email] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = address { dictionary[SerializationKeys.address] = value }
        if let value = lastName { dictionary[SerializationKeys.lastName] = value }
        if let value = age { dictionary[SerializationKeys.age] = value }
        if let value = firstName { dictionary[SerializationKeys.firstName] = value }
        if let value = salary { dictionary[SerializationKeys.salary] = value }
        if let value = imageUrl { dictionary[SerializationKeys.imageUrl] = value }
        if let value = contactNumber { dictionary[SerializationKeys.contactNumber] = value }
        if let value = dob { dictionary[SerializationKeys.dob] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.address = aDecoder.decodeObject(forKey: SerializationKeys.address) as? String
        self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
        self.age = aDecoder.decodeObject(forKey: SerializationKeys.age) as? Int
        self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
        self.salary = aDecoder.decodeObject(forKey: SerializationKeys.salary) as? Int
        self.imageUrl = aDecoder.decodeObject(forKey: SerializationKeys.imageUrl) as? String
        self.contactNumber = aDecoder.decodeObject(forKey: SerializationKeys.contactNumber) as? String
        self.dob = aDecoder.decodeObject(forKey: SerializationKeys.dob) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: SerializationKeys.email)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(address, forKey: SerializationKeys.address)
        aCoder.encode(lastName, forKey: SerializationKeys.lastName)
        aCoder.encode(age, forKey: SerializationKeys.age)
        aCoder.encode(firstName, forKey: SerializationKeys.firstName)
        aCoder.encode(salary, forKey: SerializationKeys.salary)
        aCoder.encode(imageUrl, forKey: SerializationKeys.imageUrl)
        aCoder.encode(contactNumber, forKey: SerializationKeys.contactNumber)
        aCoder.encode(dob, forKey: SerializationKeys.dob)
    }
    
}
