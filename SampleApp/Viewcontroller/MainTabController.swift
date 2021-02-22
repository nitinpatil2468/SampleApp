//
//  ViewController.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//


import UIKit

class MainTabController: UITabBarController {

    // Mark: - Properties
    let actionButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.backgroundColor =  #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        btn.setImage(UIImage(named: "chat"), for: .normal)
        btn.addTarget(self, action: #selector(actionButtontapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    // Mark: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        configureViewControllers()
        configureUI()
    }
    
    
    // Mark: - Helpers
    
    func configureUI(){
        
        self.hideKeyboardTappedArround()

        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }

    func configureViewControllers(){
        
        let vc1 = templateNavigationConroller(image: UIImage(named:"home_unselected"), rootViewController: ExampleController())
        let vc2 = templateNavigationConroller(image: UIImage(named:"settings"), rootViewController: ViewController())
        let vc3 = templateNavigationConroller(image: UIImage(named:"menu1"), rootViewController: FeedController())
       
        viewControllers = [vc1,vc2,vc3]
    }
    
    func templateNavigationConroller(image:UIImage?,rootViewController:UIViewController)->UIViewController{
        
        let vc = rootViewController
        vc.tabBarItem.image = image
        return vc
        
    }
    
    @objc func actionButtontapped(){
        
        let vc = ChatDetailsController()
        self.navigationController?.pushViewController(vc, animated: true)

    }

}

