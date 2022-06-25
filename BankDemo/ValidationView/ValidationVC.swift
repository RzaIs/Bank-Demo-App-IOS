//
//  ValidationVC.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 24.06.22.
//

import UIKit
import SnapKit

class ValidationVC: UIViewController {
    
    private var API = APIController.instance
    
    private var number: String = "+234-7087139241"
    
    private lazy var verifyImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "verify")
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "OTP Verification"
        label.textAlignment = .center
        label.font = UIFont.Bold(size: 28)
        self.view.addSubview(label)
        return label
    }()
    
    
    private lazy var numberInfoLabels = UIView()
    
    private lazy var inputField: OTPField = {
        let field = OTPField()
        field.setupView()
        self.view.addSubview(field)
        return field
    }()
    
    private lazy var resendOTPLabels: UIView = {
       
        let leftLbl = UILabel()
        leftLbl.text = "Didn’t recieve an OTP?"
        leftLbl.textColor = UIColor(hexaRGB: "#87898E")
        leftLbl.font = UIFont.Regular(size: 16)
        
        let rightLbl = UILabel()
        rightLbl.text = "Resend OTP"
        rightLbl.textColor = UIColor(hexaRGB: "#FF6565")
        rightLbl.font = UIFont.Regular(size: 16)
        
        let view = UIView()
        view.addSubview(leftLbl)
        view.addSubview(rightLbl)
        
        leftLbl.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        rightLbl.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(leftLbl.snp.right).offset(6)
        }
        
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var verifyBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Verify & Proceed", for: .normal)
        btn.setTitleColor(UIColor(hexaRGB: "#FFFFFF"), for: .normal)
        btn.titleLabel?.font = UIFont.Bold(size: 18)
        btn.backgroundColor = UIColor(hexaRGB: "#407AFF")
        btn.layer.cornerRadius = 28
        
        self.view.addSubview(btn)
        return btn
    }()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
                
        self.numberInfoLabels = getNumberInfoLabels(number: number)
        
        self.verifyImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(72)
            make.left.equalToSuperview().offset(72)
            make.right.equalToSuperview().offset(-72)
            make.height.equalTo(verifyImage.snp.width)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(verifyImage.snp.bottom).offset(64)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.numberInfoLabels.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(16)
        }
        
        self.inputField.snp.makeConstraints { make in
            make.top.equalTo(numberInfoLabels.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
        }
        
        self.resendOTPLabels.snp.makeConstraints { make in
            make.top.equalTo(inputField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(16)
        }
        
        self.verifyBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(56)
        }
        
        verifyBtn.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(verify(_:)))
        )
    }
    
    
    public var Number: String {
        get {
            return self.number
        }
        set {
            self.number = newValue
        }
    }
    
    private func getNumberInfoLabels(number: String) -> UIView {
        
        let leftLbl = UILabel()
        leftLbl.text = "Enter the OTP sent to"
        leftLbl.textColor = UIColor(hexaRGB: "#87898E")
        leftLbl.font = UIFont.Regular(size: 16)
        
        let rightLbl = UILabel()
        rightLbl.text = number
        rightLbl.textColor = UIColor(hexaRGB: "#000000")
        rightLbl.font = UIFont.Bold(size: 16)

        
        let view = UIView()
        view.addSubview(leftLbl)
        view.addSubview(rightLbl)
        
        leftLbl.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        rightLbl.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(leftLbl.snp.right).offset(6)
        }
        
        self.view.addSubview(view)
        return view
    }
    
    @objc func verify(_ sender: UITapGestureRecognizer) {
        guard let code = Int(self.inputField.text) else {
            let OTPAlert = UIAlertController(title: "Invalid Code", message: "Code should be 4 digit", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            OTPAlert.addAction(ok)
            self.present(OTPAlert, animated: true)
            return
        }
        
        Task {
            do {
                self.navigationController?.pushViewController(LoadingVC(nibName: nil, bundle: nil), animated: true)
                try await API.verifyOTP(otpParams: OTPParams(OTP: code))
                self.navigationController?.viewControllers = [CompletionVC(nibName: nil, bundle: nil)]
            } catch {
                let failAlert = UIAlertController(title: "Invalid Code", message: "Entered OTP code is not correct", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                failAlert.addAction(ok)
                
                self.navigationController?.popViewController(animated: true)
                self.present(failAlert, animated: true)
            }
        }
    }
}
