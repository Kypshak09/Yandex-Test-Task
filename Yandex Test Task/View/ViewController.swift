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
    
    let identifier = "identifier"
    
    let table: UITableView = {
        let table = UITableView()
        return table
    }()
    
    let allListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stocks", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let favouriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favourite", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Find company or ticker"
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
        
        setConstraints()
        
        request.getData(urlStringName) { apiData in
            self.dataName = apiData.response
//            print(self.dataName)
            self.table.reloadData()
        }
        
        requesrPrice.getData(urlStringPrice) { apiData in
            self.dataPrice = apiData.responce
            print(self.dataPrice)
            self.table.reloadData()
        }
        
        
        
    }
    
    func setConstraints() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(400)
        }
        
        view.addSubview(allListButton)
        allListButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(100)
            make.centerY.equalTo(searchBar.snp_bottomMargin).offset(100)
        }
        view.addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { make in
            make.leading.equalTo(allListButton.snp_trailingMargin).offset(100)
            make.centerY.equalTo(searchBar.snp_bottomMargin).offset(100)
        }
        
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(favouriteButton.snp_bottomMargin).offset(100)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
    }


}


//MARK: - table view methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? StockCell else {return UITableViewCell()}
        if indexPath.row % 2 == 0 {
            cell.customView.backgroundColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
        } else {
            cell.customView.backgroundColor = .white
        }
        cell.configure(dataModelName: dataName[indexPath.row], dataModelPrice: dataPrice[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
