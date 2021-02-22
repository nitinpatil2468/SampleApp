//
//  UserDBHelper.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//


import Foundation
import CoreData
import UIKit


@available(iOS 11.0, *)
class UserDBHelper{
    
    static var sharedInstance = UserDBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

 

    func addNewEntry(jsonString:String){

        var Entries = [User]()
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")

        do
        {
            Entries = try context?.fetch(fetchRequest) as! [User]

                let entry = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
                entry.chatInfo = jsonString
        }
        catch
        {
            print(error)
        }

        do{
            try context?.save()
        }catch{
            print("no data")
        }
    }

    func getEntries() -> [User]?{

        var entries = [User]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        do {
            entries = try context?.fetch(fetchRequest) as! [User]
        } catch {

            print("Failed")
        }
        return entries
    }

}

