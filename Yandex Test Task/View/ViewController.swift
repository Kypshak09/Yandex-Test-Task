//
//  ViewController.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 26.01.2023.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    let company = CompanyData()
    let symbol = SymbolData()
    var priceData = [PriceData]()
    let priceRequest = PriceRequest()
    
    let identifier = "identifier"
    
    let table: UITableView = {
        let table = UITableView()
        return table
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.tintColor = .black
        search.layer.cornerRadius = 20
        search.clipsToBounds = true
        search.placeholder = "Find company or ticker"
        search.searchBarStyle = .minimal
        search.frame = CGRect(x: 0, y: 0, width: 350, height: 60)
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(StockCell.self, forCellReuseIdentifier: identifier)
        navigationItem.hidesSearchBarWhenScrolling = true
        searchBar.delegate = self
        view.addSubview(searchBar)
        table.tableHeaderView = searchBar
        
        setConstraints()
        
        for symbol in SymbolData().symbolNames {
            priceRequest.getPrice(symbol: symbol) { priceData in
                self.priceData = priceData
                self.table.reloadData()
            }
        }
        
    }

    func setConstraints() {
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}


//MARK: - table view methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? StockCell else {return UITableViewCell()}
        if indexPath.row % 2 == 0 {
            cell.customView.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        } else {
            cell.customView.backgroundColor = .white
        }
        cell.configure(symbolData: symbol, companyData: company,priceData: priceData, index: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
// MARK: - UISearchBar
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = dataName.filter {
//            $0.name.lowercased().contains(searchText.lowercased())
//            }
//            table.reloadData()
    }
}
