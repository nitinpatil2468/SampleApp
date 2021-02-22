//
//  User+CoreDataProperties.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var message: String?
    @NSManaged public var chatInfo: String?

}

extension User : Identifiable {

}
