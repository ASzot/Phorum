//
//  ImageCaptureViewController.swift
//  Phorum
//
//  Created by Chaitanya Pilaka on 11/9/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import Firebase

class ImageCaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, DefaultResponder {
    @IBOutlet weak var picture: UIImageView!
    static let EVENT_SELECTOR_STORYBOARD_ID = "EventSelectorVCStoryboardID"
    let cameraPicker = UIImagePickerController()
    var userId: String?
    var photoData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCamera()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventSelectorVC = segue.destination as? EventSelectorViewController {
            eventSelectorVC.delegate = self
            eventSelectorVC.userId = self.userId
            eventSelectorVC.imageData = self.photoData
        }
    }
    
    func onDone(senderType: Any.Type, data: Any?) {
        self.dismiss(animated: true, completion: {});
    }
    
    func onCancel(senderType: Any.Type) {
        self.dismiss(animated: true, completion: {});
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
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        cameraPicker.dismiss(animated: true, completion: nil)
        
        self.tabBarController?.selectedIndex = 0
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageToSave : UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        if let imageData = UIImageJPEGRepresentation(imageToSave, 1.0) {
            self.photoData = imageData
            
            let eventSelectorVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ImageCaptureViewController.EVENT_SELECTOR_STORYBOARD_ID)
            self.present(eventSelectorVC, animated: true, completion: nil)
        }
        else {
            print("Could not convert image to jpeg")
        }
    }
}
