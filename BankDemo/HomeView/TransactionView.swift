//
//  TransactionView.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 25.06.22.
//

import UIKit
import SnapKit

class TransactionView: UITableViewCell {

    private lazy var flowImage: UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SemiBold(size: 16)
        label.textColor = .black
        self.addSubview(label)
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Regular(size: 13)
        label.textColor = UIColor(hexaRGB: "#87898E")
        self.addSubview(label)
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SemiBold(size: 16)
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    public func setupView(transactionData: TransactionResponse) {
        
        descriptionLabel.text = transactionData.description
        dateLabel.text = "\(transactionData.date.day) \(transactionData.date.month) \(transactionData.date.year)"
        amountLabel.text = "\(transactionData.currency)\(transactionData.amount)"
        
        if transactionData.incoming {
            amountLabel.text = "+" + (amountLabel.text ?? "")
            amountLabel.textColor = UIColor(hexaRGB: "#1BE387")
            flowImage.image = UIImage(named: "income")
        } else {
            amountLabel.text = "-" + (amountLabel.text ?? "")
            amountLabel.textColor = UIColor(hexaRGB: "#FF6565")
            flowImage.image = UIImage(named: "outcome")
        }

        self.flowImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(flowImage.snp.right).offset(8)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(2)
            make.left.equalTo(flowImage.snp.right).offset(8)
        }
    
        self.amountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview()
        }
    }
}
