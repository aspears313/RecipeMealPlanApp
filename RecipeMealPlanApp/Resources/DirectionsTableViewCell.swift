//
//  DirectionsTableViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 9/12/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class DirectionsTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.layer.borderWidth = 3.0
//        view.layer.borderColor = UIColor.red.cgColor
//        view.layer.cornerRadius = 25.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description 1"
        label.textColor = .black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        //label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 26)
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
        cellView.addSubview(descriptionLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        descriptionLabel.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }

}
