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
        image.image = memeImage
    }
}
