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
        self.present(cameraPicker, animated: true, completion: nil)


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
       // self.present(cameraPicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        cameraPicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let imageToSave : UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        var jpegImage = UIImageJPEGRepresentation(imageToSave,1.0)
        
        //have to save jpeg image to database
        
        
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
