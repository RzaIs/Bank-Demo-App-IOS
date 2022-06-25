//
//  SelectView.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 23.06.22.
//

import UIKit
import SnapKit

class SelectView: UIView {
    
    private var countryNames: [String] = {
        return Countries.nameToCode.keys.sorted { name1, name2 in
            name1 < name2
        }
    }()
    
    private lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        self.addSubview(view)
        return view
    }()
    
    
    private lazy var fieldImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "country")
        self.addSubview(view)
        return view
    }()
    
    private lazy var dropBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "drop"), for: .normal)
        self.addSubview(btn)
        return btn
    }()
    
    public func setupView(expandShrink: UITapGestureRecognizer) {
        
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexaRGB: "#DADADA")?.cgColor
        
        dropBtn.addGestureRecognizer(expandShrink)
                
        self.fieldImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        self.dropBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(16)
        }
        
        self.pickerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.fieldImage.snp.right).offset(16)
            make.right.equalTo(self.dropBtn.snp.left).offset(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
    }
    
    public func shrink() {
        self.dropBtn.transform = self.dropBtn.transform.rotated(by: -3.14)
        self.pickerView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    public func expand() {
        self.dropBtn.transform = self.dropBtn.transform.rotated(by: 3.14)
        self.pickerView.snp.removeConstraints()
        self.pickerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(self.fieldImage.snp.right).offset(16)
            make.right.equalTo(self.dropBtn.snp.left).offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    public var text: String {
        get {
            let name = countryNames[self.pickerView.selectedRow(inComponent: 0)]
            return Countries.nameToCode[name] ?? "nil"
            
        }
    }
}

extension SelectView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countryNames.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryNames[row]
    }
}
