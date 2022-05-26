//
//  ViewController.swift
//  TestCollectionView
//
//  Created by なぐも on 2022/05/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 170, height: 170)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 50
            collectionView.collectionViewLayout = layout
    }
        
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 12

        return cell
    }
}

