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
    var mainUIBlur: UIVisualEffectView?

    @IBOutlet weak var mainUIView: UIView!
    @IBOutlet weak var savedDispView: UIView!
    @IBOutlet weak var downloadBtnBkgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        dispImageView.image = setImage
        savedDispView.isHidden = true
        downloadBtnBkgView.layer.cornerRadius = 10.0
        downloadBtnBkgView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSaveImage(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(self.setImage!, nil, nil, nil);
        savedDispView.isHidden = false
        blurRestOfUI()
        let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.hideCheckImage), userInfo: nil, repeats: false);
    }
    
    func blurRestOfUI() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        self.mainUIBlur = UIVisualEffectView(effect: blurEffect)
        self.mainUIBlur!.frame = mainUIView.bounds
        
        mainUIView.addSubview(self.mainUIBlur!)
    }
    
    func unblurRestOfUI() {
        self.mainUIBlur?.removeFromSuperview()
    }
    
    func hideCheckImage() {
        unblurRestOfUI()
        savedDispView.isHidden = true
    }
}
