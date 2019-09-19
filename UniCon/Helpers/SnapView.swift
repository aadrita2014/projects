//
//  SnapView.swift
//  UniCon
//
//  Created by Ricky on 9/18/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

class SnapView: UIView {

    var snapGesture:SnapGesture?
    var label:UILabel? = nil
    var sticker:UIImageView? = nil
    var showEditingControl = false
    var deleteButton:UIButton?
    var resizeButton:UIButton?
    var editTextButton:UIButton?
    
    //ACtion
    var deleteClickedAction:((SnapView)->Void)?
    var editTextClickedAction:((SnapView)->Void)?
    var resizeClickedAction:((SnapView)->Void)?
//
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(label:UILabel,toView:UIView) {
        let frame = CGRect(x:0,y:0,width:label.frame.width + 32,height: label.frame.height + 32)
        super.init(frame: frame)
        label.center = self.center
        self.center = toView.center
        self.addSubview(label)
        self.label = label
        snapGesture = SnapGesture(view: self)
       // self.addBorderColor(borderWidth: 0.5, color: UIColor.white)
        addDeleteButton()
        addResizeButton()
        addEditTextButton()
        addTapGesture()
        updateView()
    }
    init(sticker:UIImageView,toView:UIView) {
        let frame = CGRect(x:0,y:0,width:sticker.frame.width + 32,height: sticker.frame.height + 32)
        super.init(frame: frame)
        sticker.center = self.center
        self.center = toView.center
        self.addSubview(sticker)
        self.sticker = sticker
        snapGesture = SnapGesture(view: self)
        addDeleteButton()
        addResizeButton()
        addTapGesture()
        updateView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addDeleteButton() {
        deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "delete_cross_icon")?.withRenderingMode(.alwaysOriginal)
        deleteButton?.setImage(image, for: .normal)
        deleteButton?.tintColor = UIColor.black
        deleteButton?.backgroundColor = UIColor.white
        deleteButton?.center = CGPoint(x: 0, y: 0)
        deleteButton?.addCornerRadius(radius: deleteButton!.viewWidth()/2.0)
        deleteButton?.addTarget(self, action: #selector(deleteClicked), for: .touchUpInside)
        self.addSubview(deleteButton!)
    }
    func addEditTextButton() {
        editTextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        editTextButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        editTextButton?.setTitle("T", for: .normal)
        editTextButton?.setTitleColor(UIColor.black, for: .normal)
        editTextButton?.backgroundColor = UIColor.white
        editTextButton?.center = CGPoint(x: 0, y: self.viewHeight())
        editTextButton?.addCornerRadius(radius: editTextButton!.viewWidth()/2.0)
        editTextButton?.addTarget(self, action: #selector(editTextClicked), for: .touchUpInside)
        self.addSubview(editTextButton!)
    }
    func addResizeButton() {
        resizeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "resize_icon")?.withRenderingMode(.alwaysOriginal)
        resizeButton?.setImage(image, for: .normal)
        resizeButton?.tintColor = UIColor.black
        resizeButton?.backgroundColor = UIColor.white
        resizeButton?.center = CGPoint(x: self.viewWidth(), y: self.viewHeight())
        resizeButton?.addCornerRadius(radius: resizeButton!.viewWidth()/2.0)
        resizeButton?.addTarget(self, action: #selector(resizeClicked), for: .touchUpInside)
        self.addSubview(resizeButton!)
    }
    //MARK: Button Actions
    @objc func deleteClicked() {
        print("Delete")
        if let action = deleteClickedAction {
            print("Delete")
            action(self)
        }
    }
    @objc func editTextClicked() {
        print("Edit Text")
        if let action = editTextClickedAction {
            print("Edit Text")
            action(self)
        }
    }
    @objc func resizeClicked() {
        print("Resize")
        if let action = resizeClickedAction {
            print("Resize")
            action(self)
        }
    }
    func updateView() {
        if showEditingControl {
            self.addBorderColor(borderWidth: 0.5, color: UIColor.white)
            if let _ = label {
                deleteButton?.isHidden = false
                resizeButton?.isHidden = false
                editTextButton?.isHidden = false
            }
            else {
                deleteButton?.isHidden = false
                resizeButton?.isHidden = false
                editTextButton?.isHidden = true
            }
           // snapGesture = nil
           
        }
        else {
            self.addBorderColor(borderWidth: 0.0, color: UIColor.white)
            deleteButton?.isHidden = true
            resizeButton?.isHidden = true
            editTextButton?.isHidden = true
            //snapGesture = SnapGesture(view: self)
        }
        if let btn = deleteButton {
            bringSubviewToFront(btn)
        }
        if let btn = editTextButton {
            bringSubviewToFront(btn)
        }
        if let btn = resizeButton {
            bringSubviewToFront(btn)
        }
    }
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showEditingControls))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }
    @objc func showEditingControls() {
        showEditingControl = !showEditingControl
        updateView()
    }
    //MARK: Add Resizable, Rotatable snap view to the video container
    static func addSnapView(toView:UIView,label:UILabel) -> SnapView{

        return SnapView(label: label,toView: toView)
    }
    
    static func addSnapView(toView:UIView, fromImage image:UIImage) -> SnapView{
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height:  100))
        imageView.isUserInteractionEnabled = true
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        let snapView = SnapView(sticker: imageView,toView: toView)
       
        return snapView
    }

    static func addSnapView(toView:UIView,emoji:String,fontSize:Double) -> SnapView{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        label.text = emoji
        label.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        label.sizeToFit()
        let snapView = SnapView(label: label,toView: toView)
    
        return snapView
    }
}
