//
//  CameraViewController.swift
//  Phorum
//
//  Created by Chaitanya Pilaka on 11/8/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    let captureSession = AVCaptureSession()
    var captureInput: AVCaptureDevice?
    var captureOutput: AVCapturePhotoOutput?
    
    
    
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var previewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        // Dispose of any resources that can be recreated.
        
    }
    
    func defaultCamera() -> AVCaptureDevice?{
        if let device = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
            return device
            
        }else{
            return nil
        }
    }
    
    func configureInput(){
        
        captureInput = defaultCamera()
        do{
            let cameraInput = try AVCaptureDeviceInput(device: captureInput)
            captureSession.addInput(cameraInput)
        }catch{
            print("Camera not working")
        }
    }
    
    func configureOutput(){
        captureOutput = AVCapturePhotoOutput()
        
        //let photoFormat = [AVVideoCodecKey as String: AVVideoCodecJPEG]
        //let photoSettings = AVCapturePhotoSettings(format: photoFormat)
        //captureOutput?.capturePhoto(with: photoSettings, delegate: self)
        
        captureSession.addOutput(captureOutput)
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput,
                          didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?,
                          previewPhotoSampleBuffer: CMSampleBuffer?,
                          resolvedSettings: AVCaptureResolvedPhotoSettings,
                          bracketSettings: AVCaptureBracketedStillImageSettings?,
                          error: Error?){
        
        if let error = error {
            print(error.localizedDescription)
        }
        
        
    }
    


    override func viewWillAppear(_ animated: Bool) {
        
        configureInput()
        configureOutput()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.frame = previewView.bounds
        previewView.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
        
        
      
        
       
        
     
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
