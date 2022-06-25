//
//  InputField.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 23.06.22.
//

import UIKit
import SnapKit

enum FieldType {
    case text(logoImage: UIImage?), password(logoImage: UIImage?)
}

enum PasswordValidation {
    case valid, invalid(msg: String)
}

class InputField: UIView {
    
    private lazy var fieldImage: UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        return view
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.font = UIFont.Regular(size: 16)
        self.addSubview(field)
        return field
    }()
    
    public func setupView(inputFieldInfo: InputFieldInfo) {
        
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexaRGB: "#DADADA")?.cgColor
        
        self.textField.placeholder = inputFieldInfo.placeholder
        
        switch inputFieldInfo.fieldType {
        case .text(let img):
            self.fieldImage.image = img
        case .password(let img):
            self.fieldImage.image = img
            self.textField.isSecureTextEntry = true
        }
        
        fieldImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(fieldImage.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    public func isValidEmail() -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self.textField.text)

        return result
    }
    
    public func isValidPassword() -> PasswordValidation {
        
        guard let text = self.textField.text else { return .invalid(msg: "Password cannot be empty") }
        
        if text.contains(" ") { return .invalid(msg: "Password cannot contain spaces") }
        
        return .valid
    }
    
    public var text: String {
        get {
            return self.textField.text ?? ""
        }
    }
}
