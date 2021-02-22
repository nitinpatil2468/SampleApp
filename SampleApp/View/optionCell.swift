//
//  optionCell.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//

import Foundation
import UIKit
//
class optionCell : UITableViewCell {

    
    
    let nameLabel:UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "HelveticaNeue", size: 17.0)

        return name
    }()
    
    var name:String?{
        didSet{
            manageData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        setUpConstraints()
        manageData()
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        
        nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: -5)
        
    }
    
    func manageData(){
        nameLabel.text = name
    }

}

