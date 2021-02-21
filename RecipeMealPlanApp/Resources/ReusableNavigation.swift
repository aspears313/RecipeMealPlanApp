//
//  ReusableNavigation.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 9/5/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import ChameleonFramework

class ReusableNavigation: UIView {
    
    func setNavigationBar() -> UINavigationBarAppearance {
        
        
        //let navController = UINavigationController()
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = FlatRedDark()
    
        return navBarAppearance
    }
    
    func navTitle(title: String, navigationBar: UINavigationBar) {
        
        let maxWidth = UIScreen.main.bounds.size.width - 60
        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
    
        while width > maxWidth {
            fontSize -= 1
            width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        }
        if var titleAttributes = navigationBar.largeTitleTextAttributes {
            titleAttributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: fontSize)
            titleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
    
            navigationBar.largeTitleTextAttributes = titleAttributes
            navigationBar.topItem?.title = title
            //navigationItem.title = title
        }
    }
    //    navigationController?.navigationBar.backgroundColor = UIColor.white
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
