//
//  SubClass.swift
//  Soctrack
//
//  Created by Mahajan on 01/11/18.
//  Copyright © 2018 Codemenschen. All rights reserved.
//

import Foundation
import UIKit
import IHProgressHUD
import CryptoSwift

class Main: UIViewController,UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

public class CommonFunctions: NSObject  {
    
    static let shared: CommonFunctions = {
        CommonFunctions()
    }()
    func showLoader() {
        IHProgressHUD.show()
    }
    
    func hideLoader() {
        IHProgressHUD.dismiss()
    }
    
    func showProgress(progress: CGFloat){
        IHProgressHUD.set(defaultMaskType: .black)
        IHProgressHUD.show(progress: progress * 100, status: String(format: "%.2f", progress * 100))
    }
    
    static func encryptValue(value: String) -> String {
        if let aes = try? AES(key: Keys.Encryption, iv: Keys.Encyption_Initial_Vector, padding: .pkcs5),
            let aesE = try? aes.encrypt(Array(value.utf8)) {
            return aesE.toBase64()!
        } else {
            return ""
        }
    }

    static func decryptValue(value: String) -> String {
        guard let data = Data(base64Encoded: value) else { return "" }
        if let decrypted = try? AES(key: Keys.Encryption, iv: Keys.Encyption_Initial_Vector, padding: .pkcs5).decrypt([UInt8](data)) {
            return String(bytes: decrypted, encoding: .utf8) ?? ""
        }else {
            return ""
        }
    }
    func encryptMessage(message: String, encryptionKey: String, iv: String) -> String? {
        if let aes = try? AES(key: encryptionKey, iv: iv),
            let encrypted = try? aes.encrypt(Array<UInt8>(message.utf8)) {
            return encrypted.toHexString()
        }
        return nil
    }
    

    func decryptMessage(encryptedMessage: String, encryptionKey: String, iv: String) -> String? {
        if let aes = try? AES(key: encryptionKey, iv: iv),
            let decrypted = try? aes.decrypt(Array<UInt8>(hex: encryptedMessage)) {
            return String(data: Data(bytes: decrypted), encoding: .utf8)
        }
        return nil
    }
}

class buttonProperties: UIButton {
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
}

class labelProperties : UILabel {
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    @IBInspectable var key:String? // KEY
    override func awakeFromNib() {
        
        if let  text = self.key?.localize {
            self.text = text
        }
    }
}

class imageProperties : UIImageView {
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
}

class viewProperties: UIView {
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var bottomBorder: CGFloat = 0.0 {
        didSet {
            DispatchQueue.main.async {
                let border = CALayer()
                let width = self.bottomBorder
                border.borderColor = UIColor.darkGray.cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
                border.borderWidth = width
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    @IBInspectable var squareDropShadow: Bool = false {
        didSet {
            DispatchQueue.main.async {
              
                self.layer.shadowPath =
                    UIBezierPath(roundedRect: self.bounds,
                                 cornerRadius: self.layer.cornerRadius).cgPath
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.5
                self.layer.shadowOffset = CGSize(width: -1, height: 1)
                self.layer.shadowRadius = 1
                self.layer.masksToBounds = false
                   
            }
        }
    }
    
}

class textFieldProperties: UITextField {
    @IBInspectable var dropShadow: Bool = false {
        didSet {
            let shadowPath = UIBezierPath(rect: bounds)
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            layer.shadowOpacity = 0.5
            layer.shadowPath = shadowPath.cgPath
        }
    }
    
    @IBInspectable var Radius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = Radius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var Border: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = Border
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    @IBInspectable var LeftSpace: CGFloat = 0 {
        didSet {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: LeftSpace, height: self.frame.size.height))
            view.backgroundColor = UIColor.clear
            self.leftView = view
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable var LeftImage: UIImage? {
        didSet {
            let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.size.height))
            iv.image = LeftImage
            iv.contentMode = .center
            self.leftView = iv
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable var RightSpace: CGFloat = 0 {
        didSet {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: RightSpace, height: self.frame.size.height))
            view.backgroundColor = UIColor.clear
            self.rightView = view
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable var RightImage: UIImage? {
        didSet {
            let vw = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
            let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            iv.image = RightImage
            iv.contentMode = .center
            vw.addSubview(iv)
            self.rightView = vw
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor {
         get {
             return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
         }
         set {
             guard let attributedPlaceholder = attributedPlaceholder else { return }
             let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
             self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
         }
     }
    
    @IBInspectable var bottomBorder:CGFloat = 0 {
        didSet {
            DispatchQueue.main.async {
                let border = CALayer()
                let width = self.bottomBorder
                border.borderColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0).cgColor
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
                border.borderWidth = width
                self.layer.addSublayer(border)
                self.layer.masksToBounds = true
            }
        }
    }
    private var __maxLengths = [UITextField: Int]()
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return Int.max
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t: String = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}

class switchButtonProperties: UISwitch {
    @IBInspectable public var ShadowColor: UIColor = UIColor.black {
        didSet {
            self.layer.shadowColor = self.ShadowColor.cgColor
        }
    }
    @IBInspectable public override var backgroundColor: UIColor? {
        didSet {
            self.layer.backgroundColor = self.backgroundColor?.cgColor
        }
    }
}
