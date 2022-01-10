//
//  TableViewCell.swift
//  CurrenciesConverter
//
//  Created by Rita on 28.12.2021.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let identifierCell = String(describing: ViewController.self)

    var nameLabel = UILabel()
    var currentCourse = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TableViewCell.identifierCell)
        contentView.addSubview(nameLabel)
        contentView.addSubview(currentCourse)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setup() {
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        currentCourse.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }

}
