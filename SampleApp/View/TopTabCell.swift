//
//  TopTabCell.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//

import UIKit
import Photos

class TopTabCell: UICollectionViewCell {

    

    let cardImage:UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .bottomRight
        return img
    }()
    
    var name:String?{
        didSet{
            manageData()
        }
    }
    
    var bgColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)

    
 
    let label:UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = "Titanic"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 0 // or 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configureUI()
        manageData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = self.bounds.width / 4
        clipsToBounds = true
        addSubview(cardImage)
        addSubview(label)
        
        
        label.anchor(top: topAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 5,width: self.bounds.width/1.5, height: self.bounds.height/2)
        cardImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

    }

    
    func manageData(){
        cardImage.image = UIImage(named: "person")
        label.text = name
    }

}
