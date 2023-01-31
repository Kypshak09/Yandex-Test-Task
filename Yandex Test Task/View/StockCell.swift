//
//  StockCell.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 30.01.2023.
//

import UIKit
import SnapKit

class StockCell: UITableViewCell {

    let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    let nameOfCompany: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        return label
    }()
    
    let shortName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        return label
    }()
    
    let currentPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        return label
    }()
    
    let changePrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        return label
    }()
    
    let buttonHeart: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray3
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(dataModelName: Stocks, dataModelPrice: Price) {
        nameOfCompany.text = dataModelName.name
        shortName.text = dataModelName.short_name
        currentPrice.text = "\(dataModelPrice.c) $"
        changePrice.text = "\(dataModelPrice.ch) $ (\(dataModelPrice.cp))"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-16)
            make.height.equalTo(68)
        }
        
        customView.addSubview(shortName)
        shortName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(72)
            make.trailing.equalToSuperview().offset(202)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        customView.addSubview(nameOfCompany)
        nameOfCompany.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.leading.equalToSuperview().offset(72)
            make.trailing.equalToSuperview().offset(202)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        customView.addSubview(currentPrice)
        currentPrice.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(223)
            make.trailing.equalToSuperview().offset(17)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        customView.addSubview(changePrice)
        changePrice.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.leading.equalToSuperview().offset(241)
            make.trailing.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        customView.addSubview(buttonHeart)
        buttonHeart.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(120)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-35)
            
        }
    }

}
