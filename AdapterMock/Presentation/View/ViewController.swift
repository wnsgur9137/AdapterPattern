//
//  ViewController.swift
//  AdapterMock
//
//  Created by JunHyeok Lee on 2023/05/31.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    
    private let firstTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let secondTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var adapter: TableViewAdapter?
    private let viewModel: ViewModel
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        self.viewModel = ViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter = TableViewAdapter(firstTableView: firstTableView, secondTableView: secondTableView, firstDataSource: viewModel, firstDeleagte: self, secondDataSource: viewModel, secondDelegate: self)
        
        self.view.backgroundColor = .white
        
        bindIsNeedRefresh()
        
        addSubviews()
        setupFirstTableViewLayout()
        setupSecondTableViewLayout()
        
        self.viewModel.addFirstTableContent(count: 10)
        self.viewModel.addSecondTableContent(count: 15)
    }
    
    private func bindIsNeedRefresh() {
        self.viewModel.isNeedRefresh
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.firstTableView.reloadData()
                self?.secondTableView.reloadData()
            })
            .store(in: &cancellable)
    }
}

extension ViewController: FirstTableViewDelegate {
    func didSelectItemForFirstTableView(at indexPath: IndexPath) {
        print("FirstTableView Tapped, Cell: \(indexPath.row)")
    }
}

extension ViewController: SecondTableViewDelegate {
    func didSelectItemForSecondTableView(at indexPath: IndexPath) {
        print("SecondTableView Tapped, Cell: \(indexPath.row)")
    }
}

extension ViewController {
    private func addSubviews() {
        self.view.addSubview(firstTableView)
        self.view.addSubview(secondTableView)
    }
    
    private func setupFirstTableViewLayout() {
        NSLayoutConstraint.activate([
            firstTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            firstTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            firstTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            firstTableView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func setupSecondTableViewLayout() {
        NSLayoutConstraint.activate([
            secondTableView.leadingAnchor.constraint(equalTo: firstTableView.leadingAnchor),
            secondTableView.topAnchor.constraint(equalTo: firstTableView.bottomAnchor),
            secondTableView.trailingAnchor.constraint(equalTo: firstTableView.trailingAnchor),
            secondTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
