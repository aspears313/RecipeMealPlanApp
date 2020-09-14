//
//  AddDirectionsViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 2/29/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddDirectionsViewController: UIViewController {
    
    @IBOutlet weak var addDirectionsBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    var newRecipe: Recipe?
    var newIngredients: [Ingredients] = []
    
    var directionsTableView = UITableView()
    var descriptionTextView = UITextView()
    var directionsForRecipe = [String]()
    let textViewPlaceholder = "Please enter your directions"
    
    var listNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView() {
        doneBtn.layer.cornerRadius = doneBtn.frame.height / 2.0
        setTableView()
        //Create new text View
//        descriptionTextView = directionsTextView()
    }
    //make tableView editable
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
            directionsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            directionsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            directionsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            directionsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80)
        ])
        directionsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func setTextView() {
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.text = textViewPlaceholder
        descriptionTextView.textColor = .lightGray
        descriptionTextView.backgroundColor = .white
        descriptionTextView.textAlignment = .center
        descriptionTextView.layer.cornerRadius = 25.0
        descriptionTextView.layer.borderWidth = 2.0
        descriptionTextView.layer.borderColor = UIColor.red.cgColor
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.delegate = self
        descriptionTextView.font = UIFont.systemFont(ofSize: 22)
        descriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            descriptionTextView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -30),
            descriptionTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //descriptionTextView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 135),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 45)
        ])
        textViewDidChange(descriptionTextView)
    }
    
    @IBAction func addDirectionsBtnTapped(_ sender: Any) {
        setTextView()
        //Instead of tableview going away animate it going down to a new position then coming back up again.
        //Also thinking of adding just view layer on top of the tableview to make it look faded
        addBlur()
//        directionsTableView.isHidden = true
        descriptionTextView.isHidden = false
        addDirectionsBtn.isEnabled = false
    }
    
    func addBlur() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            directionsTableView.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = directionsTableView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.tag = 100
            
            directionsTableView.addSubview(blurEffectView)
        } else {
            view.backgroundColor = .white
        }
    }
    
    func removeBlur() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        } else {
            print("No")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddDirectionsViewController: UITextViewDelegate {
    
    /*Functions are not all textView functions but
     Are all used with either the keyboard or the
     textView in some way.
    */
    
    func textViewDidChange(_ textView: UITextView) {
        //print(descriptionTextView.text!)
        let size = CGSize(width:self.view.frame.width - 16, height: .infinity)
        let estimatedSize = descriptionTextView.sizeThatFits(size)
        
        descriptionTextView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.lightGray {
            descriptionTextView.text = nil
            descriptionTextView.textColor = .black
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = textViewPlaceholder
            descriptionTextView.textColor = .lightGray
        }
        return true
    }
    
    func hideKeyboard() {
        descriptionTextView.resignFirstResponder()
        descriptionTextView.isHidden = true
        //newRecipe?.directions?.append("\(listNumber). \(descriptionTextView.text ?? "This string didn't work.")")
        directionsForRecipe.append("\(listNumber). \(descriptionTextView.text ?? "This string didn't work.")")
        listNumber += 1
        showAlert()
        addDirectionsBtn.isEnabled = true
        removeBlur()
        directionsTableView.reloadData()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Success!", message: "Your instruction was added", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)})
    }
    
    @objc func tapDone(sender: Any) {
        descriptionTextView.resignFirstResponder()
        self.view.endEditing(true)
        hideKeyboard()
        //Have this transition animated.
//        addDirectionsBtn.isEnabled = true
//        removeBlur()
//        directionsTableView.reloadData()
    }
    
}

extension AddDirectionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directionsForRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = directionsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DirectionsTableViewCell
        
        cell.backgroundColor = .white
        cell.descriptionLabel.text = directionsForRecipe[indexPath.row]
        
        return cell
    }
}

extension AddDirectionsViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Please Add Directions"
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Tap the button above to add your first instruction."
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        let backColor = UIColor.white
        return backColor
    }
}
