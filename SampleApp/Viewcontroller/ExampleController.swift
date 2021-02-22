//
//  ExampleController.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//

import Foundation
import UIKit


class ExampleController: UIViewController {
    

    private lazy var lbl1 : UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome!! This functionality not implemented yet"
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        lbl.numberOfLines = 0 // or 1
        return lbl
    }()
    
    let TitleLabel:UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = "Home"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24.0)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        configureUI()
    }
    
    func viewWillAppear(){
        navigationController?.navigationBar.isHidden = true

    }

    func configureUI(){
        
        self.hideKeyboardTappedArround()
        navigationController?.navigationBar.isHidden = true

        navigationController?.navigationBar.barStyle = .black // tintcolor for item set to white
        self.view.addSubview(lbl1)
        lbl1.centerX(inView: view)
        lbl1.centerY(inView: view)
        lbl1.anchor(left: view.leftAnchor,right : view.rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        self.view.addSubview(TitleLabel)
        TitleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 15, paddingLeft: 10)

}

}

