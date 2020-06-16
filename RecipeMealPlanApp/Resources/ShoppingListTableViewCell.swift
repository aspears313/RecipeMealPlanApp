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
        view.layer.cornerRadius = 25.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Item 1"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var checkMarkImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25.0
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "unchecked")
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: ingredientLabel.text!)
        attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSRange(location: 0, length: ingredientLabel.text!.count))
        let newText = NSMutableAttributedString(string: ingredientLabel.text!)
        
        ingredientLabel.attributedText = selected ? attributeString : newText
        
        self.checkMarkImageView.image = selected ? UIImage(named: "checked") : UIImage(named: "unchecked")
    }
    
    func setupView() {
        
        addSubview(cellView)
        cellView.addSubview(ingredientLabel)
        cellView.addSubview(checkMarkImageView)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        ingredientLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        ingredientLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        ingredientLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        ingredientLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        checkMarkImageView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        checkMarkImageView.widthAnchor.constraint(equalToConstant: 66).isActive = true
        checkMarkImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        checkMarkImageView.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
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
