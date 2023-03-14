//
//  ViewController.swift
//  arthur_test
//
//  Created by Arthur Stapassoli on 13/03/23.
//

import UIKit
import Alamofire
import Combine
import Charts

class ViewController: UIViewController, UITableViewDelegate, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    private var bindings = Set<AnyCancellable>()
    private var items = [VariationItem]()
    let cellReuseIdentifier = "cell"
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        viewModel.fetchData()
        bindViewModelToView()
        
    }
    
    private func setUpChart() {
        self.lineChartView.delegate = self
    }
    
    private func setUpTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
    }
    
    private func bindViewModelToView() {
        viewModel.$variations.sink { [weak self] (variations) in
            self?.items = variations
            self?.tableView.reloadData()
        }.store(in: &bindings)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?
        
        cell?.textLabel?.text = formatRow(it: self.items[indexPath.row])
        
        return cell!
    }
    
    func formatRow(it: VariationItem) -> String {
        "\(String(it.day))   :   \(String(format: "%.2f", it.price))   :   \(String(format: "%.2f", it.variationD1))   :   \(String(format: "%.2f", it.variationDayOne))"
    }
    
}
