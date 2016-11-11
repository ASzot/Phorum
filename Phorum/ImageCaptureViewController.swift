//
//  ImageCaptureViewController.swift
//  Phorum
//
//  Created by Chaitanya Pilaka on 11/9/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import Firebase
import DigitsKit

class ImageCaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, DefaultResponder {
    @IBOutlet weak var picture: UIImageView!
    static let EVENT_SELECTOR_STORYBOARD_ID = "EventSelectorVCStoryboardID"
    static let TO_EVENT_SELECTOR_SEGUE = "CameraViewToEventSelectView"
    let cameraPicker = UIImagePickerController()
    var userId: String?
    var imageData: Data?
    var showCamera:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCamera()
        self.userId = Digits.sharedInstance().session()?.userID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onDone(senderType: Any.Type, data: Any?) {
        print("onDone")
        self.showCamera = true
        self.dismiss(animated: true, completion: {});
    }
    
    func onCancel(senderType: Any.Type) {
        print("onCancel")
        self.showCamera = false
        self.dismiss(animated: true, completion: {});
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventSelectorVC = segue.destination as? EventSelectorViewController {
            eventSelectorVC.delegate = self
            eventSelectorVC.userId = self.userId
            eventSelectorVC.imageData = self.imageData
        }
    }
    
    func configureCamera(){
        cameraPicker.delegate = self
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            cameraPicker.sourceType = UIImagePickerControllerSourceType.camera
            cameraPicker.cameraCaptureMode = .photo
            cameraPicker.modalPresentationStyle = .fullScreen
            cameraPicker.allowsEditing = false
        }
        else{
            print("camera")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        cameraPicker.dismiss(animated: true, completion: nil)
        self.tabBarController?.selectedIndex = 0
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageToSave : UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        if let imageData = UIImageJPEGRepresentation(imageToSave, 1.0) {
            self.imageData = imageData
            self.showCamera = false
            cameraPicker.dismiss(animated: false) {
                self.performSegue(withIdentifier: ImageCaptureViewController.TO_EVENT_SELECTOR_SEGUE, sender: nil)
            }
        }
        else {
            print("Could not convert image to jpeg")
        }
    }
}
