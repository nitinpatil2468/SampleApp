//
//  CustomCollectionViewCell.swift
//  SampleApp
//
//  Created by Nitin Patil on 21/02/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    private lazy var NameFIeld : UITextField = {
        let tf = Utilities().textField(placeholder: "Who is this investment for?")
        tf.isUserInteractionEnabled = true
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.addTransparentView))
        tf.addGestureRecognizer(touch)
        return tf
    }()
    
    private lazy var NameContainerView : UIView = {
        let view = Utilities().inputContainerView(tf: NameFIeld)
        return view
    }()
    
    private lazy var typeSwitch : UISwitch = {
        let sc = UISwitch()
        sc.isOn = true
        sc.setOn(true, animated: false)
        sc.addTarget(self, action: #selector(self.switchValueDidChange(sender:)), for: .valueChanged)
        sc.tintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        return  sc
    }()
    
    private lazy var switchView : UIView = {
        let view = Utilities().inputContainerView(sc: typeSwitch, tf1: lbl1, tf2: lbl2)
        return view
    }()
    
    let pickerData = ["Self", "Wife", "Family"]

    private lazy var lbl1 : UILabel = {
        let lbl = UILabel()
        lbl.text = "Fixed"
        return lbl
    }()
    
    private lazy var lbl2 : UILabel = {
        let lbl = UILabel()
        lbl.text = "Available"
        return lbl
    }()
    
    lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        datePicker.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        datePicker.setDate(Date(), animated: false)
        datePicker.addTarget(self, action: #selector(self.datePickerChanged(sender:)), for:.valueChanged)
        return datePicker
    
    }()
    
    private lazy var dateView : UIView = {
        let view = Utilities().inputContainerView(dateLabel: datePicker)
        return view
    }()
    
    private let unitTextField : UITextField = {
        let tv = Utilities().textField(placeholder: "Number of units")
        tv.keyboardType = .numberPad
        return tv
    }()
    
    private lazy var unitContainerView : UIView = {
        let view = Utilities().inputContainerView(tf: unitTextField)
        return view
    }()
    
    private let priceTextField : UITextField = {
        let tv = Utilities().textField(placeholder: "Purchase price")
        tv.keyboardType = .numberPad
        return tv
    }()
    
    private lazy var priceContainerView : UIView = {
        let view = Utilities().inputContainerView(tf: priceTextField)
        return view
    }()
    
    lazy var addButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add more", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        button.setDimensions(width: 150, height: 40)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for:.touchUpInside);
        button.isUserInteractionEnabled = true
        return button
    }()
    
 
    lazy var table:UITableView = {
    let tv = UITableView(frame: .zero)
    tv.showsHorizontalScrollIndicator = false
    tv.delegate = self
    tv.dataSource = self
        tv.isScrollEnabled = false
    tv.register(optionCell.self, forCellReuseIdentifier: "cell")
    tv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    tv.tableFooterView = UIView()

    return tv
}()
    
    let tv = UIView()
    
    
    var stackView = UIStackView()
    
    var name = String()
    var isFixed = Bool()
    var date = String()
    var unit = String()
    var price = String()

    @IBAction func datePickerChanged(sender: UIDatePicker) {
       print("print \(sender.date)")
      let dt = (sender.date.timeIntervalSince1970 * 1000).rounded()
        date = String(dt)
   }
    
    @objc func addTransparentView(){
        let window = UIApplication.shared.keyWindow
        tv.frame = window?.frame ?? self.frame
        addSubview(tv)
        
        
        self.table.frame = CGRect(x: self.stackView.frame.origin.x + 8, y: self.stackView.frame.origin.y + 50, width: self.stackView.frame.width - 16, height: 0)
        addSubview(table)
        table.layer.cornerRadius = 5

        
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.removeView))
        tv.addGestureRecognizer(touch)
        self.tv.alpha = 0

        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.tv.alpha = 0.5
            self.table.frame = CGRect(x: self.stackView.frame.origin.x + 8, y: self.stackView.frame.origin.y + 50, width: self.stackView.frame.width - 16, height: 90)


        }, completion: nil)
    }
    
    @objc func removeView(){
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.tv.alpha = 0
            self.table.frame = CGRect(x: self.stackView.frame.origin.x + 8, y: self.stackView.frame.origin.y + 50, width: self.stackView.frame.width - 16, height: 0)


        }, completion: nil)
    }
    
    @objc func switchValueDidChange(sender:UISwitch!)
    {
        if (sender.isOn == true){
            print("on")
            isFixed = false
        }
        else{
            print("off")
            isFixed = true
        }
    }
    

    @objc func handleLogin(){
        
        unit = unitTextField.text!
        price = priceTextField.text!
        
        let dt = (datePicker.date.timeIntervalSince1970 * 1000).rounded()
        date = String(dt)
        
        let dict = ["date":date,"price":price,"unit":unit,"fixed":isFixed,"relation":name] as [String : Any]
        let vc = Utilities().topViewController()
        
        let isValidate = Utilities().validation(dict)
        if isValidate{
            CustomerDBHelper.sharedInstance.addNewEntry(dict)
            vc.popupAlert(title: "Alert", message: "Saved Successfully.", actionTitles: ["Ok"], actions: [nil])
        }else{
            let vc = Utilities().topViewController()
            vc.popupAlert(title: "Alert", message: "Please Fill required detatils", actionTitles: ["Ok"], actions: [nil])
        }
        
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
        
        stackView.backgroundColor = #colorLiteral(red: 0.9999136329, green: 0.9961318374, blue: 0.894012332, alpha: 1)
        
        stackView = UIStackView(arrangedSubviews: [NameContainerView,switchView,dateView,unitContainerView,priceContainerView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        addSubview(addButton)

        
        stackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        stackView.anchor(top: topAnchor, left: leftAnchor,right: rightAnchor,paddingTop: 15, paddingLeft:15,paddingRight: 15)
        addButton.centerX(inView: self, topAnchor: stackView.bottomAnchor, paddingTop: 10)
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CustomCollectionViewCell :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! optionCell
        cell.backgroundColor = #colorLiteral(red: 0.9999136329, green: 0.9961318374, blue: 0.894012332, alpha: 1)
        cell.name = pickerData[indexPath.row]
        return cell
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NameFIeld.text = "Who is this investment for : \(pickerData[indexPath.row])"
        name = pickerData[indexPath.row]
        self.removeView()
    }

}

