//
//  MemeCollectionViewController.swift
//  MemeApp
//
//  Created by Muhammad Zeeshan Shabbir on 3/18/17.
//  Copyright © 2017 Muhammad Zeeshan Shabbir. All rights reserved.
//

import Foundation
import UIKit
class MemeCollectionViewController: UICollectionViewController {
    
    var memes : [Meme]!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureFlowLayout()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.meme
        collectionView?.reloadData()
    }
    
    func configureFlowLayout(){
        
        let space: CGFloat = 3.0
        let diemension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: diemension, height: diemension)

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.image.image = meme.memeImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewer") as! MemeDetailViewer
        let meme = memes[(indexPath as NSIndexPath).row]
        controller.memeImage = meme.memeImage
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func newMeme(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as! MemeEditorViewController
        self.present(controller, animated: true, completion: nil)
    }
    
}

