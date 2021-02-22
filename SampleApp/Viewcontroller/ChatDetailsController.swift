//
//  ChatDetailsController.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//


import UIKit

class ChatDetailsController: UIViewController {

    // Mark: - Properties

    var orignalHeight : CGFloat?
    var descriptionTVHeightConstraint: NSLayoutConstraint?
    var messageArray = [[String:String]]()
    var objArray = [EntryItem]()
    



    
    lazy var collectionView:UICollectionView = {
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.showsVerticalScrollIndicator = false
    cv.setCollectionViewLayout(layout, animated: false)
    cv.delegate = self
    cv.dataSource = self
    cv.register(ChatCell.self, forCellWithReuseIdentifier: "cell")
    cv.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    return cv
}()

    
    lazy var txtView:UITextView = {
        
        let tv = UITextView.init(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        tv.isScrollEnabled = true
        tv.showsVerticalScrollIndicator = false
        tv.delegate = self
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.contentInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5);
        tv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.clipsToBounds = true;
        tv.layer.cornerRadius = 5;
        return tv

    }()
    

    lazy var btn:UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setTitle("Send", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setDimensions(width: 80, height: 40)
        btn.addTarget(self, action: #selector(sendText), for: .touchUpInside)
        return btn

    }()
    
    
    // Mark: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureUI()
        self.hideKeyboardTappedArround()

    }
    
    // Mark: - Helpers
    func configureUI(){
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(self.collectionView)
        self.view.addSubview(txtView)
        self.view.addSubview(btn)
        
        btn.anchor(bottom: view.layoutMarginsGuide.bottomAnchor,right:view.rightAnchor)
        txtView.anchor(left: view.leftAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, right: btn.leftAnchor, paddingLeft: 5, paddingBottom: 5, paddingRight: 0)

        self.descriptionTVHeightConstraint = txtView.heightAnchor.constraint(equalToConstant: 70)
        self.descriptionTVHeightConstraint?.isActive = true
        
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 0, paddingRight: 0)
        collectionView.bottomAnchor.constraint(greaterThanOrEqualTo: txtView.topAnchor, constant: -5).isActive = true

        let leftButton = UIBarButtonItem(title:"Back", style: .plain, target: self, action: #selector(dissmiss))
        navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.title = "Romi - The chatBot"
        
        self.getData()
    }
    
    func getData(){
        var entries = [User]()
        let timeStamp = (Date().timeIntervalSince1970 * 1000).rounded()

        let initialDict = ["time":String(timeStamp),"message":"Hi,i am Romi.I am your assistant"]
        let obj = EntryItem(dict : initialDict)
        objArray.append(obj)
        entries = UserDBHelper.sharedInstance.getEntries()!
        if let userInfo = entries.last{
            if let jsonString = userInfo.chatInfo{
                print(jsonString)
                if let array = Utilities().convertToDictionary(text: jsonString){
                    messageArray = array
                    for dict in messageArray{
                        let obj = EntryItem(dict : dict)
                        objArray.append(obj)
                    }
                }}
    }
        collectionView.reloadData()
    }
    
    @objc func dissmiss(){
        self.dismiss(animated: true) {
            if (self.messageArray.count > 0){
                if let jsonString = Utilities().getJsonString(object: self.messageArray){
                    print(jsonString)
                    UserDBHelper.sharedInstance.addNewEntry(jsonString: jsonString)
                }
            }
        }
        navigationController?.navigationBar.isHidden = true

        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        self.orignalHeight = self.txtView.frame.size.height

    }
    
    @objc func sendText(){
        let text = txtView.text
        if text != ""{
            let timeStamp = (Date().timeIntervalSince1970 * 1000).rounded()
            var dict = [String:String]()
            dict["message"] = text;
            dict["time"] = String(timeStamp);
            messageArray.append(dict)
            
            let obj = EntryItem(dict : dict)
            objArray.append(obj)
            let insertionIndexPath : IndexPath = IndexPath(item: objArray.count - 1, section: 0)
            let array = [insertionIndexPath]
            collectionView.insertItems(at: array)
            collectionView.scrollToItem(at: insertionIndexPath as IndexPath, at: .bottom, animated: true)
            txtView.text = nil
        }
    }
}

extension ChatDetailsController: UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout{
    
     var flipsHorizontallyInOppositeLayoutDirection: Bool {
          return true
      }

    var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
            return UIUserInterfaceLayoutDirection.rightToLeft
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        print(objArray.count)
        return objArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChatCell
        cell.data = objArray[indexPath.row]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let newFrame = NSString(string: (objArray[indexPath.row].getMessage())!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        var width = newFrame.width
        if indexPath.row % 2 != 0 {
            if width < 80  {
                width = 80
            }
            cell.chatTextView.frame = CGRect(x: view.frame.width - width - 50, y: 10, width: width + 35 , height: newFrame.height + 35)
            cell.chatTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.nameLabel.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        }else{
            
            if width < 80  {
                width = 80
            }
            cell.chatTextView.frame = CGRect(x: 15, y: 10, width: width + 35 , height: newFrame.height + 35)
            cell.chatTextView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.nameLabel.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)


        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let newFrame = NSString(string: (objArray[indexPath.row].getMessage())!).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        return CGSize(width: view.frame.width  , height: newFrame.height + 35)

    }
    
  
}

extension ChatDetailsController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
        let fixedWidth = textView.frame.size.width

        /// Here we need to get The height as Greatest that we can have or expected
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        /// Get New Size
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        /// New Frame
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)

        /// Orignal height is height that is assigned to TextView for first time and 100 is maximum height that textview can increase
        self.descriptionTVHeightConstraint?.constant = CGFloat(min(100,max(Int(newFrame.size.height),Int(self.orignalHeight!))))

    }
}



