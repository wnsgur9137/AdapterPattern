//
//  TableViewAdapter.swift
//  AdapterMock
//
//  Created by JunHyeok Lee on 2023/05/31.
//

import UIKit

protocol FirstTableViewDataSource: AnyObject {
    func numberOfItemsForFirstTableView() -> Int
    func cellForItemForFirstTableView(at index: Int) -> TableViewCellInformation
}

protocol FirstTableViewDelegate: AnyObject {
    func didSelectItemForFirstTableView(at indexPath: IndexPath)
}

protocol SecondTableViewDataSource: AnyObject {
    func numberOfItemsForSecondTableView() -> Int
    func cellForItemForSecondTableView(at index: Int) -> TableViewCellInformation
}

protocol SecondTableViewDelegate: AnyObject {
    func didSelectItemForSecondTableView(at indexPath: IndexPath)
}

final class TableViewAdapter: NSObject {
    private let firstTableView: UITableView
    weak var firstDataSource: FirstTableViewDataSource?
    weak var firstDelegate: FirstTableViewDelegate?
    
    private let secondTableView: UITableView
    weak var secondDataSource: SecondTableViewDataSource?
    weak var secondDelegate: SecondTableViewDelegate?
    
    init(firstTableView: UITableView, secondTableView: UITableView, firstDataSource: FirstTableViewDataSource, firstDeleagte: FirstTableViewDelegate, secondDataSource: SecondTableViewDataSource, secondDelegate: SecondTableViewDelegate) {
        firstTableView.register(TableViewFirstCell.self, forCellReuseIdentifier: TableViewFirstCell.identifier)
        secondTableView.register(TableViewSecondCell.self, forCellReuseIdentifier: TableViewSecondCell.identifier)
        
        self.firstTableView = firstTableView
        self.secondTableView = secondTableView
        self.firstDataSource = firstDataSource
        self.firstDelegate = firstDeleagte
        self.secondDataSource = secondDataSource
        self.secondDelegate = secondDelegate
        super.init()
        firstTableView.delegate = self
        firstTableView.dataSource = self
        secondTableView.delegate = self
        secondTableView.dataSource = self
    }
}

extension TableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            return firstDataSource?.numberOfItemsForFirstTableView() ?? 0
        } else {
            return secondDataSource?.numberOfItemsForSecondTableView() ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstTableView {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: TableViewFirstCell.identifier, for: indexPath) as? TableViewFirstCell,
                let text = self.firstDataSource?.cellForItemForFirstTableView(at: indexPath.row).text else {
              return .init()
          }
            firstCell.contentLabel.text = text
            return firstCell
        } else {
            guard let secondCell = tableView.dequeueReusableCell(withIdentifier: TableViewSecondCell.identifier, for: indexPath) as? TableViewSecondCell,
                  let text = self.secondDataSource?.cellForItemForSecondTableView(at: indexPath.row).text else {
                return .init()
            }
            secondCell.contentLabel.text = text
            return secondCell
        }
    }
}

extension TableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == firstTableView {
            firstDelegate?.didSelectItemForFirstTableView(at: indexPath)
        } else {
            secondDelegate?.didSelectItemForSecondTableView(at: indexPath)
        }
        
    }
}
