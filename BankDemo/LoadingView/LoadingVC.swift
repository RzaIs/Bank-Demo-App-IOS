//
//  LoadingVC.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 24.06.22.
//

import UIKit
import SnapKit

class LoadingVC: UIViewController {
    
    private lazy var loadingImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "loading")
        self.view.addSubview(view)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.animate(times: 5)
                
        self.loadingImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func animate(times: Int) {
        if times == 1 {
            UIView.animate(withDuration: 1, delay: 0) { [weak self] in
                guard let this = self else { return }
                this.loadingImage.transform = this.loadingImage.transform.rotated(by: 2)
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0) { [weak self] in
                guard let this = self else { return }
                this.loadingImage.transform = this.loadingImage.transform.rotated(by: 2)
            } completion: { [weak self] _ in
                self?.animate(times: times - 1)
            }
        }
    }
}
