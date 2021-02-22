//
//  ViewController.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    lazy var topcollectionView:UICollectionView = {
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.showsVerticalScrollIndicator = false
    cv.setCollectionViewLayout(layout, animated: false)
    cv.delegate = self
    cv.dataSource = self
    cv.register(TopTabCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = #colorLiteral(red: 0.9999136329, green: 0.9961318374, blue: 0.894012332, alpha: 1)
    return cv
}()
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 4
        collectionView.backgroundColor = #colorLiteral(red: 0.9999136329, green: 0.9961318374, blue: 0.894012332, alpha: 1)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(SampleCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    let TitleLabel:UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.text = "Goals"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24.0)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let forwardImage:UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.image = #imageLiteral(resourceName: "forward")
        img.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        img.setDimensions(width: 40, height: 40)
        img.layer.cornerRadius = 20
        img.contentMode = .left
        return img
    }()
    
    let backImage:UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .right
        img.image = #imageLiteral(resourceName: "back")
        img.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        img.setDimensions(width: 40, height: 40)
        img.layer.cornerRadius = 20
        return img
    }()
    
   
    
    let tabArray = ["Your info","Know you better","Know your risk","Your family"]
    var loadedIndex = Int()

    
    
    func configureUI() {
        
        self.hideKeyboardTappedArround()

        navigationController?.navigationBar.isHidden = true

        navigationController?.navigationBar.barStyle = .black // tintcolor for item set to white
        self.view.addSubview(TitleLabel)
        
        TitleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 15, paddingLeft: 10)
 
        self.view.backgroundColor = #colorLiteral(red: 0.9999136329, green: 0.9961318374, blue: 0.894012332, alpha: 1)
        
        self.view.addSubview(topcollectionView)
        topcollectionView.anchor(top: TitleLabel.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10,height: view.bounds.height/8)
        
        
        self.view.addSubview(collectionView)
        collectionView.anchor(top: topcollectionView.bottomAnchor, left: view.leftAnchor,bottom :view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom : 15, paddingRight: 15 )
        
        self.view.addSubview(backImage)
        backImage.anchor(right: collectionView.leftAnchor,paddingRight: -10 )
        backImage.centerY(inView: collectionView)
        
        self.view.addSubview(forwardImage)
        forwardImage.anchor(left: collectionView.rightAnchor,paddingLeft: -10 )
        forwardImage.centerY(inView: collectionView)
        
        view.bringSubviewToFront(collectionView)

    

    }
    
    func viewWillAppear(){
        navigationController?.navigationBar.isHidden = true

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topcollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopTabCell
            cell.name =  tabArray[indexPath.row]

            if (loadedIndex == indexPath.row){
                print("setted : \(indexPath.row)")
                cell.cardImage.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)

            }else{
                cell.cardImage.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.8099641913, blue: 0.8030235638, alpha: 1)

            }
            return cell
            
        }else{
            if indexPath.row % 2 == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CustomCollectionViewCell
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SampleCell
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == topcollectionView{
            
            let width = collectionView.bounds.width
            return CGSize(width: width / 4 - 10, height: width / 4 - 10)
            
        }else{
            
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)

        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topcollectionView{
                        return 10
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topcollectionView{
            
            return 10
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topcollectionView{
            loadedIndex = indexPath.row
            topcollectionView.reloadData()
            self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
         
        }else{
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells{
            let indexpath = collectionView.indexPath(for: cell)
            print("selected : \(indexpath!.row)")
            loadedIndex = indexpath!.row
            topcollectionView.reloadData()
        }

    }

}





