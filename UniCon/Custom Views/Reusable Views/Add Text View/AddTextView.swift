//
//  AddTextView.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

//
//  AddStickersPopupView.swift
//  UniCon
//
//  Created by Ricky on 9/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class AddTextView: UIView {
    
    
    struct FontModel {
        let text, fontName:String
    }
    let kCONTENT_XIB_NAME = "AddTextView"
    
    //MARK: IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var bottomContainerView: UIView!
    @IBOutlet var textFontCollView:UICollectionView!
    @IBOutlet var colorCollView:UICollectionView!
    @IBOutlet var textView:UITextField!
    @IBOutlet var textFillModeToggleButton:UIButton!
    @IBOutlet var textAlignmentButton:UIButton!
    
    //To pass result to the called view acts as delegate
    var dismissViewAction:(()->Void)?
    var addTextToParent:((UILabel)->Void)?
    
    var selectedColor:UIColor = UIColor.white
    var textFillMode:TextFillMode = .textOnly
    var textAlignmentMode:TextAlignment = .center
    
    fileprivate typealias TextColorModel = UIColor
    //Demo Models
    fileprivate var colorModels:[TextColorModel] = [AppColors.redTextColor,
                                                    AppColors.orangeTextColor,
                                                    AppColors.yellowTextColor,
                                                    AppColors.greenTextColor,
                                                    AppColors.royalBlueTextColor,
                                                    AppColors.cyanTextColor,
                                                    AppColors.pinkTextColor,
                                                    AppColors.grayTextColor,
                                                    AppColors.whiteTextColor,
                                                    AppColors.lighGreenTextColor]
    
    var fontModels:[FontModel] = [FontModel(text: "나눔명조", fontName: "NanumMyeongjo-Regular"),
                                  FontModel(text: "개구", fontName: "Gaegu-Regular"),
                                  FontModel(text: "도현", fontName: "DoHyeon-Regular")]
    var centerConstraint:NSLayoutConstraint!
    var leftConstraint:NSLayoutConstraint!
    var rightConstraint:NSLayoutConstraint!
    
    //MARK: View Setup Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //Contents of a nib file are unarchived
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit() {
        
        //Loading the view from the nib file
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        
        //Register collecion view nibs
        colorCollView.register(UINib(nibName: "AddTextColorCell", bundle: nil), forCellWithReuseIdentifier: "ColorCell")
        textFontCollView.register(UINib(nibName: "AddTextFontCell", bundle: nil), forCellWithReuseIdentifier: "FontCell")
        contentView.fixInView(self)
        
        //Register for keyboard notifications
        setupViewResizerOnKeyboardShown()
        
        //Set text fill mode button image for rendering
        let imgOriginal = UIImage(named: "iconText")?.withRenderingMode(.alwaysTemplate)
        textFillModeToggleButton.setImage(imgOriginal, for: .normal)
        
        //Initialize text view constraints
        centerConstraint = textView.centerXAnchor.constraint(equalTo: centerXAnchor)
        leftConstraint = textView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)
        rightConstraint = textView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8)
        
        //Apply text fill mode initial settings
        updateTextFill()
        
        //Apply default text alignment mode settings
        alignmentModeUpdated()
    }
    
    //MARK: IBAction Methods
    @IBAction func dismissViewClicked() {
        if let action = dismissViewAction {
            action()
        }
    }
    @IBAction func toggleTextFillMode() {
        if textFillMode == .textOnly {
            textFillMode = .bgOnly
        }
        else if textFillMode == .bgOnly {
            textFillMode = .alphaBg
        }
        else {
            textFillMode = .textOnly
        }
        updateTextFill()
    }
    @IBAction func toggleTextAlignment() {
        if textAlignmentMode == .center {
            textAlignmentMode = .left
        }
        else if textAlignmentMode == .left {
            textAlignmentMode = .right
        }
        else {
            textAlignmentMode = .center
        }
        alignmentModeUpdated()
    }
    //MARK: Button, view & text field updates
    //Update text fill mode settings & button based on the selection
    
    func updateTextFill() {
        
        switch textFillMode {
        case .textOnly:
            
            //Button updates
            textFillModeToggleButton.addBorderColor(borderWidth: 1.0, color: UIColor.white)
            textFillModeToggleButton.backgroundColor = UIColor.clear
            textFillModeToggleButton.tintColor = UIColor.white
            textFillModeToggleButton.addCornerRadius(radius: 2)
            
            //Text field settings updates
            textView.textColor = selectedColor
            textView.backgroundColor = UIColor.clear
        case .bgOnly:
            
            //Button updates
            textFillModeToggleButton.addBorderColor(borderWidth: 0.0, color: UIColor.white)
            textFillModeToggleButton.backgroundColor = UIColor.white
            textFillModeToggleButton.tintColor = UIColor.black
            
            //Text field settings updates
            if selectedColor == .white || selectedColor == AppColors.whiteTextColor {
                textView.textColor = UIColor.black
            }
            else {
                textView.textColor = UIColor.white
            }
            textView.backgroundColor = selectedColor
        case .alphaBg:
            
            //Button updates
            textFillModeToggleButton.addBorderColor(borderWidth: 0.0, color: UIColor.white)
            textFillModeToggleButton.backgroundColor = UIColor.lightGray
            textFillModeToggleButton.tintColor = UIColor.white
            
            //Text field settings updates
            textView.textColor = UIColor.white
            textView.backgroundColor = selectedColor.withAlphaComponent(0.5)
        }
    }
    //Text alignment mode settings and update
    func alignmentModeUpdated() {
        switch textAlignmentMode {
        case .center:
            textAlignmentButton.setImage(UIImage(named: "iconCenterAlignment"), for: .normal)
            
            textView.textAlignment = .center
            centerConstraint.isActive = true
            leftConstraint.isActive = false
            rightConstraint.isActive = false
        case .left:
            textAlignmentButton.setImage(UIImage(named: "iconLeftAlignment"), for: .normal)
            
            textView.textAlignment = .left
            centerConstraint.isActive = false
            leftConstraint.isActive = true
            rightConstraint.isActive = false
        case .right:
            textAlignmentButton.setImage(UIImage(named: "iconRightAlignment"), for: .normal)
            
            textView.textAlignment = .right
            centerConstraint.isActive = false
            leftConstraint.isActive = false
            rightConstraint.isActive = true
        }
    }
    func labelFromtextField() -> UILabel{
        let label = UILabel(frame: CGRect.zero)
        label.text = textView.text
        label.textColor = textView.textColor
        label.backgroundColor = textView.backgroundColor
        label.font = textView.font
        label.sizeToFit()
        return label
    }
    //To rotate the screens and layout the views accordingly
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard
            let previousTraitCollection = previousTraitCollection,
            self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass ||
                self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass
            else {
                return
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: Collection View Delegates
extension AddTextView:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == textFontCollView {
            return fontModels.count
        }
        else {
            return colorModels.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == textFontCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FontCell", for: indexPath) as! AddTextFontCell
            let model = self.fontModels[indexPath.row]
            cell.configure()
            cell.fontText.text = model.text
            cell.fontText.font = UIFont(name: model.fontName, size: 23)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! AddTextColorCell
            let colorModel = self.colorModels[indexPath.row]
            cell.configure()
            cell.bgView.backgroundColor = colorModel
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == textFontCollView {
            let label = UILabel(frame: CGRect.zero)
            label.text = self.fontModels[indexPath.row].text
            label.sizeToFit()
            //        return CGSize(width: label.frame.width + 20, height: 30)
            return CGSize(width: label.frame.width + 20, height: collectionView.bounds.height)
        }
        else {
            return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == textFontCollView {
            textView.font = UIFont(name: self.fontModels[indexPath.row].fontName, size: 20)
        }
        else {
            //Select color model & apply it to the text
            let colorModel = self.colorModels[indexPath.row]
            self.selectedColor = colorModel
            updateTextFill()
        }
    }
    
    
}
//MARK: Text Field Delegate
extension AddTextView:UITextFieldDelegate {
    //Dismiss the view and return the text with settings to the parent view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        if let action = addTextToParent {
            action(labelFromtextField())
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}

//MARK: Keyboard hide & show, view adjustment
extension AddTextView {
    
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AddTextView.keyboardWillShowForResizing),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AddTextView.keyboardWillHideForResizing),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    @objc func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.frame = CGRect(x: self.frame.origin.x,
                                y: self.frame.origin.y,
                                width: self.frame.width,
                                height: window.origin.y + window.height - keyboardSize.height)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }
    @objc func keyboardWillHideForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.frame.height
            self.frame = CGRect(x: self.frame.origin.x,
                                y: self.frame.origin.y,
                                width: self.frame.width,
                                height: viewHeight + keyboardSize.height)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    
}
