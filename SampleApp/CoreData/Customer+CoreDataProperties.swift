//
//  Customer+CoreDataProperties.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var relation: String?
    @NSManaged public var fixed: Bool
    @NSManaged public var date: String?
    @NSManaged public var unit: String?
    @NSManaged public var price: String?

}

extension Customer : Identifiable {

}
