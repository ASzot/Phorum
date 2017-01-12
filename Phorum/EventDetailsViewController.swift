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

    @IBOutlet weak var checkImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        dispImageView.image = setImage
        checkImage.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSaveImage(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(self.setImage!, nil, nil, nil);
        checkImage.isHidden = false
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.hideCheckImage), userInfo: nil, repeats: false);
    }
    
    func hideCheckImage() {
        checkImage.isHidden = true
    }
}
