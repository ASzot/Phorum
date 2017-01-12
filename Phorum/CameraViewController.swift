//
//  CameraViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import DigitsKit

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate, DefaultResponder {
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var takeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var controlsView: UIView!
    
    
    static let TO_EVENT_SELECTOR_SEGUE = "CameraVCToEventSelectorID"
    
    var captureSession: AVCaptureSession = AVCaptureSession()
    var sessionOutput: AVCapturePhotoOutput = AVCapturePhotoOutput()
    var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    var imageData:Data?
    var userId:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userId = Digits.sharedInstance().session()?.userID
        
        takeBtn.layer.zPosition = 1000
        previewView.layer.zPosition = 0
        hideImageCheck()
    }
    
    func hideImageCheck() {
        checkImageView.isHidden = true
        takeBtn.isHidden = false
        controlsView.isHidden = true
        previewView.isHidden = false
    }
    
    func showImageCheck() {
        checkImageView.isHidden = false
        takeBtn.isHidden = true
        controlsView.isHidden = false
        previewView.isHidden = true
    }
    
    func onDone(senderType: Any.Type, data: Any?) {
        self.dismiss(animated: true, completion: {})
    }
    
    func onCancel(senderType: Any.Type) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventSelectorVC = segue.destination as? EventSelectorViewController {
            print("Seguing")
            eventSelectorVC.delegate = self
            eventSelectorVC.userId = self.userId
            eventSelectorVC.imageData = self.imageData
        }
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer {
            print("ATTEMPOTNG")
            let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: nil)
            print("UPLOADED")
            self.imageData = dataImage
            self.checkImageView.image = UIImage(data: dataImage!)
            self.showImageCheck()
        }
        else {
            print("NOT SET")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let deviceDiscoverySession = AVCaptureDeviceDiscoverySession(deviceTypes: [AVCaptureDeviceType.builtInDuoCamera, AVCaptureDeviceType.builtInTelephotoCamera,AVCaptureDeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified)
        for device in (deviceDiscoverySession?.devices)! {
            if(device.position == AVCaptureDevicePosition.back){
                do {
                    let input = try AVCaptureDeviceInput(device: device)
                    if(captureSession.canAddInput(input)){
                        captureSession.addInput(input);
                        
                        if(captureSession.canAddOutput(sessionOutput)){
                            captureSession.addOutput(sessionOutput);
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait;
                            previewView.layer.addSublayer(previewLayer);
                            captureSession.startRunning()
                        }
                    }
                }
                catch {
                    print("Could not initalize camera!");
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = previewView.bounds
    }
    
    @IBAction func onNextBtn(_ sender: Any) {
        performSegue(withIdentifier: CameraViewController.TO_EVENT_SELECTOR_SEGUE, sender: nil)
    }
    
    
    @IBAction func onCancelBtn(_ sender: Any) {
        self.hideImageCheck()
    }
    
    @IBAction func onTakePhoto(_ sender: Any) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey:AVVideoCodecJPEG])
        self.sessionOutput.capturePhoto(with: settings, delegate: self)
    }
}
