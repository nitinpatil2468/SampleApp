//
//  UserInfo.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//


import Foundation

class UserInfo: NSObject {
    
    
    private var chats : [EntryItem]?
    private var jsonString : String?

   

    
    override init(){
        super.init()
        setUserModel()
    }
    
    func setUserModel(){
        
        var entries = [User]()
        entries = UserDBHelper.sharedInstance.getEntries()!
        if let userInfo = entries.last{
            if let jsonString = userInfo.chatInfo{
                if let array = Utilities().convertToDictionary(text: jsonString){
                    var chatArray = [EntryItem]()
                    for dict in array{
                        
                        let obj = EntryItem(dict : dict)
                        chatArray.append(obj)
                        
                    }
                    print(chatArray)
                    self.chats = chatArray
                }
            }
        }
    }
    

     func getChats()->[EntryItem]?{

        return self.chats

    }
}

