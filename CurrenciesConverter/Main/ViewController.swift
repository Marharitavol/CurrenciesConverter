//
//  ViewController.swift
//  CurrenciesConverter
//
//  Created by Rita on 28.12.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    let button = UIButton(type: .system)
    let mainViewModel: MainViewModel
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        button.addTarget(self, action: #selector(setupConverterButton), for: .touchUpInside)
        navigationItem.title = "Currencies"
        waitingCallBack()
    }
    
    //    func apiResponse() {
    //        networkManager.fetchData(url: urlString) { (answers) in
    //            self.currencies = answers
    //            self.filter()
    //            DispatchQueue.main.async {
    //                self.tableView.reloadData()
    //            }
    //        }
    //    }
    
    private func waitingCallBack() {
        mainViewModel.callback = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //    func filter() {
    //        currencies = currencies.filter({ (currency) -> Bool in
    //            if currency.cc == "USD" || currency.cc == "EUR" {
    //                return true
    //            } else {
    //                return false
    //            }
    //        })
    //    }
    
    @objc func setupConverterButton() {
        
//        var array = mainViewModel.currencies
//        array.insert(Currency(rate: 1.0, cc: "UAH"), at: 0)
        //let secondViewModel = SecondViewModel(currency: array)
        let secondVC = SecondViewController(secondViewModel: mainViewModel.createSecondViewModel( ))
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        //        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifierCell)
        tableView.snp.makeConstraints { (make) in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(168)
        }
        
        view.addSubview(button)
        button.setTitle("Converter", for: .normal)
        button.layer.backgroundColor = CGColor(gray: 0.50, alpha: 0.50)
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(45)
            make.height.equalTo(65)
            make.width.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.numberOfElement()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifierCell) as! TableViewCell
        let rate = mainViewModel.rowRate(index: indexPath.row)
        let shortRate = round(rate * 100)/100
        let cc = mainViewModel.rowCc(index: indexPath.row)
        cell.nameLabel.text = cc
        cell.currentCourse.text = "\(shortRate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


