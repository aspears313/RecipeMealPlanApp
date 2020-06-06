//
//  ShoppingListTableViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 5/29/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    //@IBOutlet weak var ingredientName: UILabel!
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Item 1"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        addSubview(cellView)
        cellView.addSubview(ingredientLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        ingredientLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        ingredientLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        ingredientLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        ingredientLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        //ingredientLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //ingredientLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
