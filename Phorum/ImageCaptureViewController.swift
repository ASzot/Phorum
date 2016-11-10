//
//  ImageCaptureViewController.swift
//  Phorum
//
//  Created by Chaitanya Pilaka on 11/9/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class ImageCaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var picture: UIImageView!
    let cameraPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCamera()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        var jpegImage = UIImageJPEGRepresentation(imageToSave, 1.0)
        
        //have to save jpeg image to database
    }
}
