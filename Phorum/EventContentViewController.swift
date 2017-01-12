//
//  EventContentViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import SwiftSpinner
import DigitsKit

class EventContentViewController: UIViewController, UICollectionViewDataSource, EventContentTappedResponder {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    static let PHOTO_VIEW_CELL_REUSE_ID = "PhotoCollectionViewCell"
    static let EVENT_DETAILS_VC_ID = "EventDetailsVCID"
    
    @IBOutlet weak var ownershipTxtLbl: UILabel!
    var eventModel:EventModel?
    var dispPhotoModels:[PhotoModel] = []
    var userId: String?
    var mainUIBlur: UIVisualEffectView?

    @IBOutlet weak var eventCodeTxtLbl: UILabel!
    @IBOutlet weak var eventCodeDispView: UIView!
    @IBOutlet weak var controlsView: UIView!
    @IBOutlet weak var mainUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "anywhereTapped")
        view.addGestureRecognizer(tap)
        self.eventCodeTxtLbl.text = self.eventModel!.eventCode

        photoCollectionView.dataSource = self
        self.title = eventModel?.name
        self.userId = Digits.sharedInstance().session()?.userID
        self.eventCodeDispView.isHidden = true
        
        if eventModel!.creatorId == userId {
            self.ownershipTxtLbl.text = "Group Owner"
        }
    }
    
    func anywhereTapped() {
        if !self.eventCodeDispView.isHidden {
            self.eventCodeDispView.isHidden = true
            self.unblurRestOfUI()
        }
    }
    
    func blurRestOfUI() {
        if self.mainUIBlur == nil {
            self.mainUIBlur = getBlurView(targetView: mainUIView)
        }
        self.mainUIView.addSubview(self.mainUIBlur!)
    }
    
    func unblurRestOfUI() {
        self.mainUIBlur!.removeFromSuperview()
    }
    
    func getBlurView(targetView: UIView) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetView.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        return blurEffectView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SwiftSpinner.show("Loading")
        self.loadEventData()
        SwiftSpinner.hide()
    }
    
    @IBAction func getEventCode(_ sender: Any) {
        self.eventCodeDispView.isHidden = false
        blurRestOfUI()
    }
    
    func loadEventData() -> () {
        // Get all of the images associated with this event id.
        let eventId = eventModel?.getId()
        
        PhotoModel().getWhereEquals(key: "event_id", compareValue: eventId!) { models in
            if let photoModels = models as? [PhotoModel] {
                self.dispPhotoModels = photoModels
                
                // Reload all of the data on the main thread.
                DispatchQueue.main.async() { () -> Void in
                    self.photoCollectionView.reloadData()
                }
            }
            else {
                
            }
        }
    }
    
    func onEventContentTapped(photoId: String, cell:EventContentCollectionViewCell) -> (){
        // Navigate to the view controller displaying the details of this image.
        if let eventDetailsVC = self.storyboard!.instantiateViewController(withIdentifier: EventContentViewController.EVENT_DETAILS_VC_ID) as? EventDetailsViewController {
            
            let cgImageData:CGImage = cell.photoView.image!.cgImage!
            let newCgIm:CGImage = cgImageData.copy()!
            
            eventDetailsVC.setImage = UIImage(cgImage: newCgIm, scale: cell.photoView.image!.scale, orientation: cell.photoView.image!.imageOrientation)
            self.navigationController!.pushViewController(eventDetailsVC, animated: true)
        }
        else {
            print("Could not find VC.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dispPhotoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventContentViewController.PHOTO_VIEW_CELL_REUSE_ID, for: indexPath) as! EventContentCollectionViewCell
        
        let dispPhotoModel:PhotoModel = self.dispPhotoModels[indexPath.row]
        
        cell.photoView.downloadedFrom(link:dispPhotoModel.url)
        cell.photoId = dispPhotoModel.getId()
        cell.delegate = self
        
        return cell
    }
}
