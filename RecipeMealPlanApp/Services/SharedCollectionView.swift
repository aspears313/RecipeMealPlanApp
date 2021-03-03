//
//  SharedCollectionView.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 3/2/21.
//  Copyright © 2021 Anthony. All rights reserved.
//

//import Foundation
//
//class SharedCollectionView: UIView {
//    
//    var recipeListCollectionView: UICollectionView!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupCollectionView()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        setupCollectionView()
//    }
//    
//    func setupCollectionView() {
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
//        layout.itemSize = CGSize(width: view.frame.width-60, height: 400)
//        layout.minimumLineSpacing = 30
//        
//        
//        recipeListCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        recipeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        recipeListCollectionView.dataSource =
//        recipeListCollectionView.delegate = self
//        recipeListCollectionView.backgroundColor = .white
//        
//        recipeListCollectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "RecipeCell")
//        
//        view.addSubview(recipeListCollectionView)
//        
//        NSLayoutConstraint.activate([
//                                        recipeListCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
//                                        recipeListCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//                                        recipeListCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//                                        recipeListCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
//        ])
//    }
//
//    
//}
