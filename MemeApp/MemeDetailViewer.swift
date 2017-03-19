//
//  MemeDetailViewer.swift
//  MemeApp
//
//  Created by Muhammad Zeeshan Shabbir on 3/18/17.
//  Copyright © 2017 Muhammad Zeeshan Shabbir. All rights reserved.
//

import Foundation
import UIKit
class MemeDetailViewer: UIViewController {
    
    
    var memeImage : UIImage!

    @IBOutlet weak var image: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        image.image = memeImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
