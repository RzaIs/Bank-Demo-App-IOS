//
//  HomeVC.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 25.06.22.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private var user: UserResponse?
    private var cards: [CardResponse]?
    private var notifCount = 0
    private var transactions: [TransactionResponse]?
    
    private lazy var topView: TopView = {
        let view = TopView()        
        self.view.addSubview(view)
        return view
    }()
    
    private var stackView : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView()

        view.addSubview(stackView)
        view.isPagingEnabled = true
        view.delegate = self
        view.showsHorizontalScrollIndicator = false

        self.view.addSubview(view)
        return view
    }()
    
    private lazy var pageCtrl : UIPageControl = {
        let pc = UIPageControl()
        
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = UIColor(hexaRGB: "#007AFF")
        pc.pageIndicatorTintColor = UIColor(hexaRGB: "#AEAEB2")
        pc.addTarget(self, action: #selector(onPageCtrlChanged(_:)), for: .valueChanged)
       
        self.view.addSubview(pc)
        return pc
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "May, 2022"
        label.font = UIFont.SemiBold(size: 24)
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var transactionsTableView: TransactionsTableView = {
        let table = TransactionsTableView()
        self.view.addSubview(table)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.topView.setupView(fullname: "\(user?.firstName ?? "nil") \(user?.lastName ?? "nil")", notifCount: notifCount)

        self.cards?.forEach { card in
            let view = CardView()
            stackView.addArrangedSubview(view)
            view.setupView(cardData: card)
        }
        
        transactionsTableView.setupView(transactions: transactions ?? [])
        
        self.topView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(32)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-32)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.left.equalTo(scrollView.contentLayoutGuide.snp.left)
            make.right.equalTo(scrollView.contentLayoutGuide.snp.right)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.centerY.equalToSuperview()
        }

        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.stackView.subviews.forEach { view in
            view.snp.makeConstraints { make in
                make.width.equalTo(self.view.snp.width)
            }
        }
        
        self.pageCtrl.numberOfPages = cards?.count ?? 0
        self.pageCtrl.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(pageCtrl.snp.bottom)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        self.transactionsTableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    
    }
    
    public func setupView(user: UserResponse, notifCount: NotificationCountResponse, cards: [CardResponse], transactions: [TransactionResponse]) {
        self.cards = cards
        self.user = user
        self.notifCount = notifCount.count
        self.transactions = transactions
    }

    @objc func onPageCtrlChanged(_ sender: UIPageControl) {
        scrollView.setContentOffset(CGPoint.init(x: CGFloat(sender.currentPage) * scrollView.frame.width, y: 0), animated: true)
    }
}

extension HomeVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index  = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageCtrl.currentPage = index
    }
}
