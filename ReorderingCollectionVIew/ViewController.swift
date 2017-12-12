//
//  ViewController.swift
//  ReorderingCollectionVIew
//
//  Created by Aman Gupta on 11/12/17.
//  Copyright © 2017 Debeloper Fly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    var arrayCellTitle = [Int]()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for value in 0...20 {
            arrayCellTitle.append(value)
        }
        configureCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureCollectionView() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(actionLongPressGesture(gesture:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func actionLongPressGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

}

//MARK: - UICollectionViewDataSource Methods
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCellTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReorderingCollectionViewCell", for: indexPath) as! ReorderingCollectionViewCell
        
        cell.lableTitle.text = "\(arrayCellTitle[indexPath.row])"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row % 2 == 0 {
            return true
        } else {
            return false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let value = arrayCellTitle.remove(at: sourceIndexPath.item)
        arrayCellTitle.insert(value, at: destinationIndexPath.item)
    }
    
}
//MARK: - UICollectionViewDelegate Methods
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return IndexPath(item: 5, section: 0)
    }

    //customize the content offset to be applied during transition or update animations
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return CGPoint(x: 50, y: 0)
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout Methods
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.size.width - 20) / 2), height: ((collectionView.frame.size.width - 20) / 2))
    }
    
}
