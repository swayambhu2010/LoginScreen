//
//  UserData+CoreDataProperties.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 09/03/26.
//
//

import Foundation
import CoreData


public typealias UserDataCoreDataPropertiesSet = NSSet

extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var userName: String?
    @NSManaged public var password: String?

}

extension UserData : Identifiable {

}
