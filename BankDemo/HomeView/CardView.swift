//
//  CardView.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 25.06.22.
//

import UIKit
import SnapKit

class CardView: UIView {
 
    private lazy var bgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "card")
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexaRGB: "#407AFF")
        self.addSubview(view)
        return view
    }()
    
    private lazy var balanceValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.Bold(size: 28)
        self.bgView.addSubview(label)
        return label
    }()
    
    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "spare balance"
        label.textColor = .white
        label.font = UIFont.Regular(size: 14)
        self.bgView.addSubview(label)
        return label
    }()
    
    private lazy var visibleImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "visible")
        self.bgView.addSubview(view)
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(hexaRGB: "#407AFF")
        label.font = UIFont.SemiBold(size: 16)
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        
        self.bgView.addSubview(label)
        return label
    }()
    
    public func setupView(cardData: CardResponse) {
        
        balanceValueLabel.text = "\(cardData.currency) \(cardData.balance)"
        
        let number = cardData.code[
            cardData.code.index(cardData.code.startIndex, offsetBy: 12)..<cardData.code.index(cardData.code.endIndex, offsetBy: 0)
        ]
        
        numberLabel.text = "•• \(number)    "
        
        self.bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(150)
        }
        
        self.balanceValueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        self.balanceTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(balanceValueLabel.snp.top).offset(-8)
        }
        
        self.visibleImage.snp.makeConstraints { make in
            make.left.equalTo(balanceValueLabel.snp.right).offset(8)
            make.centerY.equalTo(balanceValueLabel.snp.centerY)
            make.height.equalTo(16)
            make.width.equalTo(20)
        }
    
        self.numberLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
}
