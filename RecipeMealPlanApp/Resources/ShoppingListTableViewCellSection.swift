//
//  ShoppingListTableViewCellSection.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 6/29/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

protocol ShoppingListTableViewCellSectionDelegate {
    func didTapCheckMarkButton(at index: IndexPath)
}

class ShoppingListTableViewCellSection: UITableViewCell {
    
    var delegate: ShoppingListTableViewCellSectionDelegate?
    var indexPath: IndexPath!
    //var button = UIButton()
    
//    var checkMarkButtonAction : () -> () = {
//        print("button tapped")
//    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 25.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let ingredientNameLabel: UILabel = {
        let label = UILabel()
        //label.text = "Ingredient Name"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkMarkButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "unchecked-white") as UIImage?
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.isSelected = false
        return button
    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setupView() {
        
        addSubview(cellView)
        cellView.addSubview(ingredientNameLabel)
        cellView.addSubview(checkMarkButton)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        checkMarkButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        checkMarkButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        checkMarkButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        checkMarkButton.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 15).isActive = true
        
        ingredientNameLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor).isActive = true
        ingredientNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        ingredientNameLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant:  -10).isActive = true
        ingredientNameLabel.leftAnchor.constraint(equalTo: checkMarkButton.leftAnchor, constant: 40).isActive = true
    
    }

}
