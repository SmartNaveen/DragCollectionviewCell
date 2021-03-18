//
//  ViewController.swift
//  DragCollectionviewCell
//
//  Created by Mr. Naveen Kumar on 17/03/21.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
}

class ImageCollectionViewCell: UICollectionViewCell {
    
}

class ViewController: UIViewController {

    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    
    var colorArray = [UIColor.red, UIColor.systemPink, UIColor.blue, UIColor.yellow, UIColor.gray, UIColor.green, UIColor.orange, UIColor.blue, UIColor.black, UIColor.systemTeal,UIColor.systemPink, UIColor.blue, UIColor.yellow, UIColor.gray, UIColor.green, UIColor.orange, UIColor.blue, UIColor.black, UIColor.systemTeal]
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressed))
        self.colorCollectionView.addGestureRecognizer(gesture)
    }

    
    @objc func handleLongPressed(_ gesture: UILongPressGestureRecognizer) {
        switch  gesture.state{
        case .began:
            if let targetIndex = colorCollectionView.indexPathForItem(at: gesture.location(in: colorCollectionView)) {
                colorCollectionView.beginInteractiveMovementForItem(at: targetIndex)
            }
        case .changed:
            colorCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: colorCollectionView))
        case .ended:
            colorCollectionView.endInteractiveMovement()
        default:
            break
        }
    }

}

 // MARK:- Delegate & Data sources
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case colorCollectionView:
            return colorArray.count
        case ImageCollectionView:
            return 10
        default:
            break
        }
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch collectionView {
        case colorCollectionView:
        cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCollectionViewCell
            cell.contentView.backgroundColor = colorArray[indexPath.item]
            return cell
        case ImageCollectionView:
            cell = ImageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
            cell.contentView.backgroundColor = .blue
                return cell
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case colorCollectionView:
            return CGSize(width: (self.colorCollectionView.frame.size.width - 20 )/3, height: 100)
        case ImageCollectionView:
            return CGSize(width: (self.ImageCollectionView.frame.size.width) , height: 250)
        default:
            break
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colorArray.remove(at: sourceIndexPath.row)
        colorArray.insert(item, at: destinationIndexPath.row)
    }
}


