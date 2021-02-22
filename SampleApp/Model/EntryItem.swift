//
//  EntryItem.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//


import Foundation


class EntryItem: NSObject {
    
    
    private var Message : String?
    private var timeStamp : String?
    private var infoDict : [String:String]?

   

    
    init(dict : [String:String]){
        super.init()
        self.infoDict = dict
        setMessageInfo()
    }

    
    func setMessageInfo(){
        setTime((infoDict?["time"])!)
        setMessage((infoDict?["message"])!)
    }
    
     func setMessage(_ message:String){

        self.Message = message;

    }
    
    func setTime(_ time:String){

       self.timeStamp = time;

   }
    
    func getMessage()->String?{

        return Message!;

   }
    
    func getTimestamp()->Double?{

        return Double(self.timeStamp!);

   }
    
   
}
