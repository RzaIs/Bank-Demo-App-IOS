//
//  CompletionVC.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 24.06.22.
//

import UIKit
import SnapKit

class CompletionVC: UIViewController {
    
    private var API = APIController.instance
    
    private lazy var doneImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "done")
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations"
        label.textColor = UIColor(hexaRGB: "#407AFF")
        label.font = UIFont.Bold(size: 28)
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You have successfully created your spare account"
        label.textColor = UIColor(hexaRGB: "#87898E")
        label.textAlignment = .center
        label.font = UIFont.Regular(size: 16)
        label.numberOfLines = 0
        self.view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.doneImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-56)
            make.centerX.equalToSuperview()
            make.height.equalTo(192)
            make.width.equalTo(224)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(doneImage.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(72)
            make.right.equalToSuperview().offset(-72)
        }
        
        fetchData()
    }
    
    private func fetchData() {
        Task {
            do {
                
                async let user = try API.getUser()
                async let notifCount = try API.getNotificationCount()
                async let cards = try API.getCards()
                async let transactions = try API.getTransaction()
                
                
                                
                let vc = HomeVC(nibName: nil, bundle: nil)
                try vc.setupView(
                    user: await user,
                    notifCount: await notifCount,
                    cards: await cards,
                    transactions: await transactions
                )
                self.navigationController?.viewControllers = [vc]

            } catch {
                let failAlert = UIAlertController(title: "Connection Error", message: "An error occurred while fetching data", preferredStyle: .alert)

                let tryAgain = UIAlertAction(title: "Try Again", style: .default) { [weak self] _ in
                    self?.fetchData()
                }
                
                failAlert.addAction(tryAgain)
                
                self.navigationController?.popViewController(animated: true)
                self.present(failAlert, animated: true)
            }
        }
    }
    
    
    deinit {
        print("comp vc deinit")
    }
}
