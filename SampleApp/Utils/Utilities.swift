//
//  Utilities.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//


import Foundation
import UIKit


class Utilities{
    
    func getJsonString(object:Any?)-> String?{
        var json : String?
        do {
            let  jsonData = try JSONSerialization.data(withJSONObject: object as Any, options: [])
                
            if let jsonText = String(data: jsonData, encoding: .utf8){
                json = jsonText

            }
         } catch {
             print(error.localizedDescription)
         }
        return json
    }
    
    func convertToDictionary(text: String) -> [[String : String]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String : String]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func inputContainerView(tf:UITextField)->UIView{
        
        let cv = UIView()
        cv.heightAnchor.constraint(equalToConstant: 50).isActive = true
     
        cv.addSubview(tf)
        tf.anchor(left:cv.leftAnchor,bottom: cv.bottomAnchor,right:cv.rightAnchor,paddingLeft: 8,paddingBottom: 8,paddingRight: 8)
        
        let borderView = UIView()
        borderView.backgroundColor = .lightGray
        cv.addSubview(borderView)
        borderView.anchor(left:cv.leftAnchor,bottom: cv.bottomAnchor,right:cv.rightAnchor,paddingLeft: 8, paddingBottom: 5, paddingRight: 8, height: 0.75)
        
        return cv
    }
    
    func inputContainerView(dateLabel:UIDatePicker)->UIView{
        
        let cv = UIView()
        cv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let nameLbl = UILabel()
        nameLbl.text = "Date of purchase"
        cv.addSubview(nameLbl)
        nameLbl.anchor(top: cv.topAnchor, left: cv.leftAnchor, right: cv.rightAnchor, paddingLeft: 8, height: 20)

        cv.addSubview(dateLabel)

        dateLabel.anchor(top: nameLbl.bottomAnchor,left:cv.leftAnchor,right:cv.rightAnchor,paddingTop:0, paddingLeft: 8,paddingRight: 8,height : 50)
        
        return cv
    }
    
    func inputContainerView(sc:UISwitch,tf1:UILabel,tf2:UILabel)->UIView{
        
        let cv = UIView()
        cv.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let nameLbl = UILabel()
        nameLbl.text = "Is the equity one time or recurring?"
        cv.addSubview(nameLbl)
        cv.addSubview(tf1)
        cv.addSubview(sc)
        cv.addSubview(tf2)
        
        nameLbl.anchor(top: cv.topAnchor, left: cv.leftAnchor, right: cv.rightAnchor, paddingLeft: 8, height: 20)
        sc.centerX(inView: cv, topAnchor: nameLbl.bottomAnchor, paddingTop: 10)
        tf1.anchor(top: sc.topAnchor, bottom: sc.bottomAnchor, right: sc.leftAnchor,paddingRight: 10,height: 30)
        tf2.anchor(top: sc.topAnchor, left: sc.rightAnchor, bottom: sc.bottomAnchor,paddingLeft: 10,height: 30)
        return cv
    }
    
    func textField(placeholder:String)->UITextField{
        
        let tf = UITextField()
        tf.textColor = .black
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }
    
    func validation(_ dict : [AnyHashable:Any])->Bool{
        print(dict)
       
        if dict["unit"] as! String == "" {
            return false
        }
        if dict["price"] as! String == "" {
            return false
        }
        if dict["relation"] as! String == "" {
            return false
        }
       return true
    }
    
    func topViewController()->UIViewController{
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController  {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController as UIViewController
        }
        return UIViewController()
        
    }
    
}
