//
//  TableViewCell.swift
//  AdapterMock
//
//  Created by JunHyeok Lee on 2023/05/31.
//

import UIKit

final class TableViewFirstCell: UITableViewCell {
    static var identifier = String(describing: TableViewFirstCell.self)
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "First content"
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.setupContentLabelLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewFirstCell {
    private func addSubviews() {
        self.addSubview(contentLabel)
    }
    
    private func setupContentLabelLayout() {
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
        ])
    }
}
