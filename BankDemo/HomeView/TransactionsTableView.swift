//
//  TransactionsTableView.swift
//  BankDemo
//
//  Created by Rza Ismayilov on 25.06.22.
//

import UIKit

class TransactionsTableView: UITableView {

    private var transactions: [TransactionResponse] = []
    
    private let TRANSACTION = "transaction"

    public func setupView(transactions: [TransactionResponse]) {
        self.transactions = transactions
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(hexaRGB: "#FCFCFC")
        self.register(TransactionView.self, forCellReuseIdentifier: TRANSACTION)
    }

}

extension TransactionsTableView : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TRANSACTION) as! TransactionView
        let info = transactions[indexPath.row]
        cell.setupView(transactionData: info)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }

}
