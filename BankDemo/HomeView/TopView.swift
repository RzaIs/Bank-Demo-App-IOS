//
//  TopView.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 25.06.22.
//

import UIKit
import SnapKit

class TopView: UIView {
    
    private lazy var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexaRGB: "#68B6BB")
        view.layer.cornerRadius = 20
        self.addSubview(view)
        return view
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morning,"
        label.textColor = .black
        label.font = UIFont.Regular(size: 18)
        self.addSubview(label)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.Bold(size: 18)
        self.addSubview(label)
        return label
    }()
    
    private lazy var ringImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ring")
        self.addSubview(view)
        return view
    }()
    
    private lazy var notifLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.font = UIFont.SemiBold(size: 12)
        label.backgroundColor = UIColor(hexaRGB: "#FF6565")
        self.ringImage.addSubview(label)
        return label
    }()
    
    public func setupView(fullname: String, notifCount: Int) {
        
        self.nameLabel.text = fullname
        self.notifLabel.text = "\(notifCount)   "
        
        self.profileView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        self.greetingLabel.snp.makeConstraints { make in
            make.left.equalTo(profileView.snp.right).offset(12)
            make.bottom.equalTo(profileView.snp.centerY)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileView.snp.right).offset(12)
            make.top.equalTo(profileView.snp.centerY)
        }
        
        self.ringImage.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(28)
            make.height.equalTo(32)
        }
        
        self.notifLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-4)
            make.right.equalToSuperview().offset(4)
        }
        
    }
    
}
