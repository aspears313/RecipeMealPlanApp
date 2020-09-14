//
//  DirectionsViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class DirectionsViewController: UIViewController {

    var recipe: Recipe?
    
    var directionsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView() {
        
        directionsTableView.backgroundColor = .white
        directionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        directionsTableView.delegate = self
        directionsTableView.dataSource = self
        directionsTableView.emptyDataSetSource = self
        directionsTableView.emptyDataSetDelegate = self
        directionsTableView.tableFooterView = UIView()
        
        directionsTableView.estimatedRowHeight = 50
        
        directionsTableView.register(DirectionsTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(directionsTableView)
        
        NSLayoutConstraint.activate([
            directionsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            directionsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            directionsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            directionsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        directionsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

extension DirectionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = recipe?.directions?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = directionsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DirectionsTableViewCell
        
        var directions = [String]()
        if let instructions = recipe?.directions {
            directions = instructions
        }
        
        let currentDirection = directions[indexPath.row]
        
        cell.descriptionLabel.text = currentDirection
        cell.backgroundColor = .white
        
        return cell
    }
}

extension DirectionsViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "There are no directions"
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        let backColor = UIColor.lightGray
        return backColor
    }
}
