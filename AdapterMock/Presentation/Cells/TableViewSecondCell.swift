//
//  TableViewSecondCell.swift
//  AdapterMock
//
//  Created by JunHyeok Lee on 2023/05/31.
//

import UIKit

final class TableViewSecondCell: UITableViewCell {
    static var identifier = String(describing: TableViewSecondCell.self)
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Second content"
        label.textColor = .label
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupContentLabelLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewSecondCell {
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
