//
//  ViewController.swift
//  Usicon2018
//
//  Created by Amjad Khan on 17/11/17.
//  Copyright © 2017 JTEGroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var contentArr: [Item] = []
    var itemContent: Content?
    let minSpacing:CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Usicon-2018"
        collectionView.register(HeaderCell.self)
        collectionView.register(ContentCell.self)
        
        setCollectionViewLayout()
        getData()
    }
    
    func getData() {
        if let items = Content.instanceFromFile("Usicon") as? Content {
            itemContent = items
            contentArr = itemContent?.items ?? []
        }
    }
    
    func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = minSpacing
        layout.minimumInteritemSpacing = minSpacing
        collectionView.collectionViewLayout = layout
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentArr.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath) as HeaderCell
            cell.configureWithData(nil, indexPath: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ContentCell
        
        let data = contentArr[indexPath.item - 1]
        cell.configureWithData(data, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            contentViewController.item = contentArr[indexPath.item - 1]
            self.navigationController?.pushViewController(contentViewController, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
                return CGSize(width: UIScreen.main.bounds.size.width, height: 400)
            }
            return CGSize(width: UIScreen.main.bounds.size.width, height: 200)
        }
        return CGSize(width: ((UIScreen.main.bounds.size.width/2) - (minSpacing/2)), height: 100)
    }
}
