//
//  OTPField.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 24.06.22.
//

import UIKit
import SnapKit

class NumberField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return super.canPerformAction(action, withSender: sender) && (action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy))
        }
}

class OTPField: UIView {

    private lazy var textField: NumberField = {
        let field = NumberField()
        field.keyboardType = .numberPad
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.font = UIFont.systemFont(ofSize: 34)
        field.defaultTextAttributes.updateValue(42, forKey: .kern)
        field.delegate = self
        self.addSubview(field)
        return field
    }()
    
    private lazy var underLine: UIView = {
        let mainView = UIView()
        
        let leftView: UIView = {
            let view  = UIView()
            
            let lview = UIView()
            lview.backgroundColor = UIColor(hexaRGB: "#DADADA")
            
            let rview = UIView()
            rview.backgroundColor = UIColor(hexaRGB: "#DADADA")
            
            view.addSubview(lview)
            view.addSubview(rview)
            
            lview.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(8)
                make.right.equalTo(view.snp.centerX).offset(-8)
                make.height.equalTo(2)
            }
            
            rview.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(view.snp.centerX).offset(8)
                make.right.equalToSuperview().offset(-8)
                make.height.equalTo(2)
            }
            
            return view
        }()
        
        let rightView: UIView = {
            let view  = UIView()
            
            let lview = UIView()
            lview.backgroundColor = UIColor(hexaRGB: "#DADADA")
            
            let rview = UIView()
            rview.backgroundColor = UIColor(hexaRGB: "#DADADA")
            
            view.addSubview(lview)
            view.addSubview(rview)
            
            lview.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(8)
                make.right.equalTo(view.snp.centerX).offset(-8)
                make.height.equalTo(2)
            }
            
            rview.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(view.snp.centerX).offset(8)
                make.right.equalToSuperview().offset(-8)
                make.height.equalTo(2)
            }
            
            return view
        }()
        
        mainView.addSubview(leftView)
        mainView.addSubview(rightView)
        
        leftView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(mainView.snp.centerX)
        }
        
        rightView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(mainView.snp.centerX)
        }
        
        self.addSubview(mainView)
        return mainView
    }()
    
    public func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(underLine.snp.left).offset(24)
            make.right.equalTo(underLine.snp.right).offset(24)
            make.height.equalTo(64)
        }
        
        self.underLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(256)
        }
    }
    
    public var text: String {
        get {
            return self.textField.text ?? ""
        }
    }

}

extension OTPField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 4
    }
}
