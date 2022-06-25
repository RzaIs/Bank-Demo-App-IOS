//
//  RegisterView.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 23.06.22.
//

import UIKit
import SnapKit

class RegisterVC: UIViewController {
    
    private var API = APIController.instance
    
    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "dollarLogo")
        self.view.addSubview(view)
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
        label.textAlignment = .center
        label.font = UIFont.Bold(size: 28)
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var firstNameField: InputField = {
        let field = InputField()
        
        let info = InputFieldInfo(fieldType: .text(logoImage: UIImage(named: "person")), placeholder: "First name")
        field.setupView(inputFieldInfo: info)
        
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var lastNameField: InputField = {
        let field = InputField()
        
        let info = InputFieldInfo(fieldType: .text(logoImage: UIImage(named: "person")), placeholder: "Last name")
        field.setupView(inputFieldInfo: info)
        
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var phoneField: InputField = {
        let field = InputField()
        
        let info = InputFieldInfo(fieldType: .text(logoImage: UIImage(named: "phone")), placeholder: "Phone number")
        field.setupView(inputFieldInfo: info)
        
        self.view.addSubview(field)
        return field
    }()
    
    
    private lazy var emailField: InputField = {
        let field = InputField()
        
        let info = InputFieldInfo(fieldType: .text(logoImage: UIImage(named: "email")), placeholder: "Email")
        field.setupView(inputFieldInfo: info)
        
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var passwordField: InputField = {
        let field = InputField()
        
        let info = InputFieldInfo(fieldType: .password(logoImage: UIImage(named: "password")), placeholder: "Password")
        field.setupView(inputFieldInfo: info)
        
        self.view.addSubview(field)
        return field
    }()
    
    private var isExpanded = false
    private lazy var countrySelect: SelectView = {
        let view = SelectView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var footerLabels: UIView = {
        let leftLabel = UILabel()
        leftLabel.textColor = UIColor(hexaRGB: "#87898E")
        leftLabel.textAlignment = .center
        leftLabel.text = "Already have an account?"
        leftLabel.font = UIFont.Regular(size: 16)
        
        let rightLabel = UILabel()
        rightLabel.text = "Sign in"
        leftLabel.textAlignment = .center
        rightLabel.textColor = UIColor(hexaRGB: "#407AFF")
        rightLabel.font = UIFont.Regular(size: 16)
        
        let view = UIView()
        
        view.addSubview(leftLabel)
        view.addSubview(rightLabel)
        
        leftLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(leftLabel.snp.right).offset(6)
        }
        
        self.view.addSubview(view)
    
        return view
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor(hexaRGB: "#FFFFFF"), for: .normal)
        btn.titleLabel?.font = UIFont.Bold(size: 18)
        btn.backgroundColor = UIColor(hexaRGB: "#407AFF")
        btn.layer.cornerRadius = 28
        
        self.view.addSubview(btn)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.countrySelect.setupView(
            expandShrink: UITapGestureRecognizer(target: self, action: #selector(expandShrink(_:)))
        )

        self.logoView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(84)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.firstNameField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.lastNameField.snp.makeConstraints { make in
            make.top.equalTo(firstNameField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.phoneField.snp.makeConstraints { make in
            make.top.equalTo(lastNameField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.emailField.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.countrySelect.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.lessThanOrEqualTo(self.registerBtn.snp.top).offset(-16)
        }
        
        self.registerBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalTo(footerLabels.snp.top).offset(-16)
            make.height.equalTo(56)
        }
        
        self.footerLabels.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-32)
        }
        
        self.registerBtn.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(register(_:)))
        )
    }
    
    @objc func expandShrink(_ sender: UITapGestureRecognizer) {
        if self.isExpanded {
            self.isExpanded = false
            self.registerBtn.isHidden = false
            self.countrySelect.shrink()
            self.countrySelect.snp.remakeConstraints { make in
                make.top.equalTo(passwordField.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(32)
                make.right.equalToSuperview().offset(-32)
            }
        } else {
            self.isExpanded = true
            self.registerBtn.isHidden = true
            self.countrySelect.expand()
            self.countrySelect.snp.remakeConstraints { make in
                make.top.equalTo(passwordField.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(32)
                make.right.equalToSuperview().offset(-32)
                make.bottom.lessThanOrEqualTo(self.footerLabels.snp.top).offset(-16)
            }
        }
        
    }
    
    @objc func register(_ sender: UITapGestureRecognizer) {
        
        guard emailField.isValidEmail() else {
            let emailAlert = UIAlertController(title: "Invalid Email", message: "Please enter a vlid email address", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            emailAlert.addAction(ok)
            self.present(emailAlert, animated: true)
            return
        }
        
        switch passwordField.isValidPassword() {
        case .invalid(let msg):
            let passwordAlert = UIAlertController(title: "Invalid Password", message: msg, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            passwordAlert.addAction(ok)
            self.present(passwordAlert, animated: true)
            return
        case .valid:
            break
        }
        
        
        Task {
            let params = RegisterParams(
                firstName: firstNameField.text,
                lastName: lastNameField.text,
                phoneNumber: phoneField.text,
                email: emailField.text,
                password: passwordField.text,
                country: countrySelect.text
            )
            
            do {
                try await API.register(registerParams: params)
                let vc = ValidationVC(nibName: nil, bundle: nil)
                vc.Number = phoneField.text
                self.navigationController?.pushViewController(vc, animated: true)
            } catch {
                let failAlert = UIAlertController(title: "Registration", message: "Registration failed, some fields are missing", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                failAlert.addAction(ok)
                self.present(failAlert, animated: true)
            }
        }
    }
}
