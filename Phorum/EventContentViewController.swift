//
//  EventContentViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class EventContentViewController: UIViewController, UICollectionViewDataSource, EventContentTappedResponder {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    static let PHOTO_VIEW_CELL_REUSE_ID = "PhotoCollectionViewCell"
    static let EVENT_DETAILS_VC_ID = "EventDetailsVCID"
    
    var eventModel:EventModel?
    var dispPhotoModels:[PhotoModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollectionView.dataSource = self
        self.loadEventData()
    }
    
    func loadEventData() -> () {
        // Get all of the images associated with this event id.
        let eventId = eventModel?.getId()
        print("Event id is \(eventId)")
        
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
        let eventDetailsVC = self.storyboard!.instantiateViewController(withIdentifier: EventContentViewController.EVENT_DETAILS_VC_ID) as! EventDetailsViewController
        eventDetailsVC.dispImageView.image = cell.photoView.image
        self.navigationController!.pushViewController(eventDetailsVC, animated: true)
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
        
        return cell
    }
}
