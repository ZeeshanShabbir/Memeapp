//
//  MemeTableViewController.swift
//  MemeApp
//
//  Created by Muhammad Zeeshan Shabbir on 3/18/17.
//  Copyright © 2017 Muhammad Zeeshan Shabbir. All rights reserved.
//

import Foundation
import UIKit
class MemeTableViewController: UITableViewController {
    
    var memes : [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.meme
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memeImage
        cell.textLabel?.text = "\(meme.topText)....\(meme.bottomText)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

