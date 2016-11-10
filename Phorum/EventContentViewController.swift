//
//  EventContentViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class EventContentViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    static let PHOTO_VIEW_CELL_REUSE_ID = "PhotoCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventContentViewController.PHOTO_VIEW_CELL_REUSE_ID, for: indexPath) as! EventContentCollectionViewCell
        
        return cell
    }
}
