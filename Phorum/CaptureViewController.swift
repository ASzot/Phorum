//
//  CaptureViewController.swift
//  Phorum
//
//  Created by Chaitanya Pilaka on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import Firebase
import DigitsKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, DefaultResponder {
    
    static let EVENT_SELECTOR_STORYBOARD_ID = "EventSelectorVCStoryboardID"
    static let TO_EVENT_SELECTOR_SEGUE = "CameraViewToEventSelectView"
    static let TO_PUBLIC_SPACES_SEGUE = "PublicSpacesSegue"
    static let TO_MY_SPACES_SEGUE = "MySpacesSegue"
    let cameraPicker = UIImagePickerController()
    var userId: String?
    var imageData: Data?
    var showCamera:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCamera()
        
        configureGestures()
        self.userId = Digits.sharedInstance().session()?.userID
    }
    
    func configureGestures(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(CaptureViewController.getMySpacesController))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(CaptureViewController.getPublicSpacesController))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func getMySpacesController(){
        print("mySpaces")
        self.performSegue(withIdentifier: CaptureViewController.TO_MY_SPACES_SEGUE, sender: nil)
    }
    
    func getPublicSpacesController(){
        print("publicSpaces")
        self.performSegue(withIdentifier: CaptureViewController.TO_PUBLIC_SPACES_SEGUE, sender: nil)
        
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
        self.showCamera = true
        self.dismiss(animated: true, completion: {});
        //let parentViewController = self.presentingViewController
        //self.present(parentViewController!, animated: false, completion: nil)
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
        //if self.showCamera {
          //  self.present(cameraPicker, animated: true, completion: nil)
        //}
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        cameraPicker.dismiss(animated: true, completion: nil)
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


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
