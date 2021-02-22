//
//  SampleCell.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//

import Foundation
import UIKit

class SampleCell: UICollectionViewCell {
    

    let nameLabel:UILabel = {
        let name = UILabel()
        name.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        name.textAlignment = .right
        name.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        name.font = UIFont.systemFont(ofSize: 20)
        name.text = "This form is under maintainance"
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    func configureUI(){
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.contentView.isUserInteractionEnabled = true
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor,bottom : bottomAnchor, right: rightAnchor,paddingTop: 15,paddingBottom : 15, paddingRight: 15)
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


