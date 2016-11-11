//
//  EventDetailsViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    @IBOutlet weak var dispImageView: UIImageView!
    var setImage:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        dispImageView.image = setImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
