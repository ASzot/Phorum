//
//  EventContentCollectionViewCell.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

protocol EventContentTappedResponder {
    func onEventContentTapped(photoId: String, cell:EventContentCollectionViewCell) -> ()
}

class EventContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    var photoId: String?
    var delegate: EventContentTappedResponder?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        photoView.isUserInteractionEnabled = true
        photoView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(img: Any) {
        self.delegate?.onEventContentTapped(photoId: self.photoId!, cell:self)
    }
}
