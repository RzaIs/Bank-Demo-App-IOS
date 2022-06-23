//
//  ViewController.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 22.06.22.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    private lazy var API = APIController.instance
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = .black
        
        btn.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(register(_:)))
        )
        
        self.view.addSubview(btn)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
    }


    @objc func register(_ sender: UITapGestureRecognizer) {
        let params = RegisterParams(firstName: "Rza", lastName: "Ism", phoneNumber: "055", email: "rzais", password: "123", country: "AZ")
        Task(priority: .medium) {
            do {
                try await API.register(registerParams: params)
                try await API.verifyOTP(otpParams: OTPParams(OTP: 4638))
                
//                async let user = API.getUser()
//                async let cards = API.getCards()
                
                let (
                    user,
                    cards,
                    transactions,
                    notificationCount
                ) = try await (
                    API.getUser(),
                    API.getCards(),
                    API.getTransaction(),
                    API.getNotificationCount()
                )
                
                print(user, "\n\n", cards, "\n\n", transactions, "\n\n", notificationCount)
                
                
                
            } catch {
                print("Error")
            }
        }
    }

}

