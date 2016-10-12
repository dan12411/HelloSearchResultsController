//
//  SearchTableViewController.swift
//  HelloSearchResultsController
//
//  Created by 洪德晟 on 2016/9/29.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let appleProducts = ["iPhone", "iMac", "Macbook Pro", "Mac mini", "iPad", "Apple Watch", "Apple TV", "Apple Pencil"]
    
    var searchController: UISearchController?  /// 用來執行搜尋工作的類別
    var resultController = UITableViewController()  /// 用來顯示搜尋結果
    var resultArray = [String]()   /// 儲存搜尋結果
    
    // 搜尋結果
    func updateSearchResults(for searchController: UISearchController) {
        if let searchWord = searchController.searchBar.text {
            resultArray = appleProducts.filter{ $0.lowercased().contains(searchWord.lowercased()) }
        }
        // 重新顯示資料
        resultController.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 產生 searchController，指定用resultController顯示搜尋結果
        searchController = UISearchController(searchResultsController: resultController)
        
        
        /// 連結SearchTableViewController
        searchController?.searchResultsUpdater = self
        
        /// 設定搜尋時，取消反灰
        searchController?.dimsBackgroundDuringPresentation = false
        
        /// 設定顯示搜尋結果的 tableView 負責告訴顯示結果的 tableView 要顯示什麼資料
        resultController.tableView.dataSource = self
        resultController.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /// 把 tableView 降下 20
        self.tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom:0.0, right: 0.0)
        /// 把搜尋欄加到Header
        self.tableView.tableHeaderView = searchController?.searchBar
    }


    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == self.tableView {
        return appleProducts.count
        } else {
            return resultArray.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = appleProducts[indexPath.row]
            return cell
        } else {
            let cell = UITableViewCell()   // 當搜尋結果不多時，很多時需註冊indentifier
            cell.textLabel?.text = resultArray[indexPath.row]
            return cell
        }
    }
}
