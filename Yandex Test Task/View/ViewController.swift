//
//  ViewController.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 26.01.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var request = Requests()
    var requesrPrice = RequestsPrice()
    let urlStringName = "https://fcsapi.com/api-v3/stock/list?country=United-states&access_key=cyTMKbSaKAPIzKyPlytsVOntW"
    let urlStringPrice = "https://fcsapi.com/api-v3/stock/latest?indices_id=1&access_key=cyTMKbSaKAPIzKyPlytsVOntW"
    
    var dataName = [Stocks]()
    var dataPrice = [Price]()
    var filteredData = [Stocks]()
    
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
    
    @objc func moveToFavourite() {
       present(FavouriteViewController(), animated: true)
        print("touched")
    }
    
    
    
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
        
        request.getData(urlStringName) { apiData in
            self.dataName = apiData.response
            self.filteredData = self.dataName
//            print(self.dataName)
            self.table.reloadData()
        }
        
        requesrPrice.getData(urlStringPrice) { apiData in
            self.dataPrice = apiData.response
//            print(self.dataPrice)
            self.table.reloadData()
        }
    }
    
    
    
    func setConstraints() {
//        view.addSubview(searchBar)
//        searchBar.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(60)
//            make.width.equalTo(400)
//        }
        
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
//            make.top.equalTo(searchBar.snp_bottomMargin).offset(20)
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
    }


}


//MARK: - table view methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? StockCell else {return UITableViewCell()}
        if indexPath.row % 2 == 0 {
            cell.customView.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        } else {
            cell.customView.backgroundColor = .white
        }
        
        cell.configure(dataModelName: filteredData[indexPath.row], dataModelPrice: dataPrice[indexPath.row])
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
        filteredData = dataName.filter {
            $0.name.lowercased().contains(searchText.lowercased())
            }
            table.reloadData()
    }
}
