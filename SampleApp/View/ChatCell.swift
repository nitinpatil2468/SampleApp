//
//  ChatCell.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//

import Foundation
import UIKit
//
class ChatCell : UICollectionViewCell {

    var data:EntryItem?{
        didSet{
            manageData()
        }
    }
    
    let nameLabel:UILabel = {
        let name = UILabel()
        name.backgroundColor = #colorLiteral(red: 0.9999136329, green: 0.9961318374, blue: 0.894012332, alpha: 1)
        name.textAlignment = .right
        name.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        name.font = UIFont.systemFont(ofSize: 12)
        return name
    }()
    
    let chatTextView:UITextView = {
        let tv  = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.backgroundColor = #colorLiteral(red: 0.9999136329, green: 0.9961318374, blue: 0.894012332, alpha: 1)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.sizeToFit()
        tv.clipsToBounds = true;
        tv.layer.cornerRadius = 5;
        return tv
    }()
    
    var tvHeightConstraint: NSLayoutConstraint?


    override init(frame: CGRect) {
        super.init(frame:frame)
        configureUI()
    }
    
    func configureUI(){
        addSubview(chatTextView)
        addSubview(nameLabel)
        setUpConstraints()
        
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        
        nameLabel.anchor( bottom: chatTextView.bottomAnchor, right: chatTextView.rightAnchor,paddingBottom: 0, paddingRight: 5,width: 100, height: 28)
        
    }
    
    func manageData(){
        guard let data = data else {return}
        chatTextView.text = data.getMessage()
        let time = getTime(timestamp: data.getTimestamp()!)
        nameLabel.text = time
    }
    
    func getTime(timestamp : Double) -> String{
        
        let date = NSDate(timeIntervalSince1970: timestamp/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let str = dateFormatter.string(from: date as Date)
        let finalString = "\(str)\("  ")\("\u{221A}")"
        return finalString
    }

}

