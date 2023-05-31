//
//  ViewModel.swift
//  AdapterMock
//
//  Created by JunHyeok Lee on 2023/05/31.
//

import Foundation
import Combine

final class ViewModel {
    private var firstTableContents: [String] = ["FirstTableViewCell: 0"]
    private var secondTableContents: [String] = ["SecondTAbleVIewCell: 0"]
    let isNeedRefresh: PassthroughSubject<Bool, Never>
    
    init() {
        isNeedRefresh = PassthroughSubject()
    }
    
    func addFirstTableContent(count: Int) {
        for i in 1...count {
            firstTableContents.append("FirstTableViewCell: \(i)")
        }
        isNeedRefresh.send(true)
    }
    
    func addSecondTableContent(count: Int) {
        for i in 1...count {
            secondTableContents.append("SecondTableViewCell: \(i)")
        }
        isNeedRefresh.send(true)
    }
}

extension ViewModel: FirstTableViewDataSource {
    func numberOfItemsForFirstTableView() -> Int {
        self.firstTableContents.count
    }
    
    func cellForItemForFirstTableView(at index: Int) -> TableViewCellInformation {
        return TableViewCellInformation(text: self.firstTableContents[index])
    }
    
    
}

extension ViewModel: SecondTableViewDataSource {
    func numberOfItemsForSecondTableView() -> Int {
        self.secondTableContents.count
    }
    
    func cellForItemForSecondTableView(at index: Int) -> TableViewCellInformation {
        return TableViewCellInformation(text: self.secondTableContents[index])
    }
    
    
}
