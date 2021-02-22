//
//  CustomerDBHelper.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//


import Foundation
import CoreData
import UIKit


@available(iOS 11.0, *)
class CustomerDBHelper{
    
    static var sharedInstance = CustomerDBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

 

    func addNewEntry(_ object:[String:Any]){

        var Entries = [Customer]()
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Customer")

        do
        {
            Entries = try context?.fetch(fetchRequest) as! [Customer]

                let entry = NSEntityDescription.insertNewObject(forEntityName: "Customer", into: context!) as! Customer
            entry.date = object["date"] as? String
            entry.price = object["price"] as? String
            entry.unit = object["unit"] as? String
            entry.fixed = object["fixed"] as? Bool ?? false
            entry.relation = object["relation"] as? String

            
        }
        catch
        {
            print(error)
        }

        do{
            print("saved")
            try context?.save()
        }catch{
            print("no data")
        }
    }

    func getEntries() -> [Customer]?{

        var entries = [Customer]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")

        do {
            entries = try context?.fetch(fetchRequest) as! [Customer]
        } catch {

            print("Failed")
        }
        return entries
    }

}


