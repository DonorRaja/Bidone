//
//  ViewController.swift
//  iOSTest
//
//  Created by Vishnu Sasikumar on 10/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables
    let viewModel: ViewModel = ViewModel()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        return indicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        NSLayoutConstraint(item: tableView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view, attribute: .centerX,
                           multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view, attribute: .leading,
                           multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView,
                           attribute: .trailing,
                           relatedBy: .equal, toItem: view,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: tableView,
                           attribute: .bottom,
                           relatedBy: .equal, toItem: view,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        //TODO:-  tableView.backgroundColor = Custom color of your choice
        
        return tableView
    }()
    
// MARK: - Variables Declaration
    var dateWiseOrders = [String: [Order]]()
    var orderList = [String]()
    
// MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBinding()
        
        self.dateWiseOrders = Utility.groupingDictionary(dict: self.viewModel.orders.value)
    }
    
    // MARK: - Functions
    
    func initBinding() {
        viewModel.orders.addObserver(fireNow: true) { [weak self] (orders) in
            self?.tableView.reloadData()
        }
    }
    
    func getLists() {
        orderList = Array(self.dateWiseOrders.keys)
        orderList = orderList.sorted {$0.compare($1, options: .numeric) == .orderedDescending}
    
    }
    
    func getNumberOfEntrysInSection (Section: Int) -> Int {

        let order:String = self.orderList[Section]

        let value:[Order] = self.dateWiseOrders[order]!

        return value.count
    }
    
    func requestForOrderList(indexPath: IndexPath) -> [Order] {
        let sectionList = self.orderList[indexPath.section]
         let rowsList = self.dateWiseOrders[sectionList]
        
        return rowsList!
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfEntrysInSection(Section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.getLists()
        return self.orderList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return orderList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Bidone.cell, for: indexPath)
        
        let rowsList = self.requestForOrderList(indexPath: indexPath)
        
        cell.textLabel?.text = rowsList[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = UIStoryboard.init(name: Bidone.main, bundle: Bundle.main).instantiateViewController(withIdentifier: Bidone.detailVC) as? DetailsViewController
        let rowsList = self.requestForOrderList(indexPath: indexPath)
        let orderDetail = rowsList[indexPath.row]

        vc?.orderDetails = orderDetail
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

