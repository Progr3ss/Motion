//
//  CreateGifMainView.swift
//  Gif Motion
//
//  Created by Martin Chibwe on 6/27/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices





class CreateGifMainView: UIViewController  {
    
    let frameCount = 16
    let delayTime: Float = 0.2
    let loopCount = 0
    
    @IBOutlet weak var cameraView: UIView!
    
    
    @IBOutlet weak var createGifButton: UIButton!
    
    let captureSession = AVCaptureSession()
    var currentDevice:AVCaptureDevice?
    var videoFileOutput:AVCaptureMovieFileOutput?
    var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var stackViewCamera: UIStackView!
    var isRecording = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewCamera()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let buttoFrame = C
//        let buttonFrame = CGRect(x: 0, y: 0, width: 250, height: 100)
////        let button = CircularProgressButton(frame: buttonFrame, cornerRadius: 20)
//        button.setTitle("Upload", for: .normal)
//        CircularProgressButton(frame: createGifButton, cornerRadius: 20)
//        let proofOFConceptGif = UIImage.gif(url: "hotlineBling")
//        let button
        
    }
    
    
    
    func mainViewCamera()  {
        // Preset the session for taking photo in full resolution
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        // Get the available devices that is capable of taking video
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
        
        // Get the back-facing camera for taking videos
        for device in devices {
            if device.position == AVCaptureDevicePosition.back {
                currentDevice = device
            }
        }
        
        let captureDeviceInput:AVCaptureDeviceInput
        do {
            captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
        } catch {
            print(error)
            return
        }
        // Configure the session with the output for capturing video
        videoFileOutput = AVCaptureMovieFileOutput()
        
        // Configure the session with the input and the output devices
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(videoFileOutput)
        
        // Provide a camera preview
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraView.layer.addSublayer(cameraPreviewLayer!)
        cameraView.bringSubview(toFront: stackViewCamera)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.frame = cameraView.layer.frame
        captureSession.startRunning()
    }
    
  //GIF conversion methods
    
    func convertVideoToGIF(_ videoURL: URL)  {
        let regift = Regift(sourceFileURL:videoURL, frameCount:frameCount,delayTime:delayTime,loopCount:loopCount)
        let gifURL  = regift.createGif()
        
        displayGIF(gifURL!)
        
    }
    
    func displayGIF(_ url: URL) {
        let gifFilterVC = storyboard?.instantiateViewController(withIdentifier: "GifFilter") as! GifFilter
        
        gifFilterVC.gifVideoFileURL = url
        navigationController?.pushViewController(gifFilterVC, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gifEdit" {
            let gifFilterViewController = segue.destination as! GifFilter
            
            let gifFileURL = sender as! URL
            gifFilterViewController.gifVideoFileURL = gifFileURL
            
        }
    }
        
    
    
    @IBAction func createGifButtonPressed(_ sender: Any) {
        print("Recording")
                if !isRecording {
                    isRecording = true
                    
//                    UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: { () -> Void in
//                        self.createGifButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//                  )
                    
                    let outputPath = NSTemporaryDirectory() + "output.mov"
                    let outputFileURL = URL(fileURLWithPath: outputPath)
                    videoFileOutput?.startRecording(toOutputFileURL: outputFileURL, recordingDelegate: self as AVCaptureFileOutputRecordingDelegate)
                } else {
                    
                    isRecording = false
                    
                    //            UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: { () -> Void in
                    //                self.cameraButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    //            }, completion: nil)
                    //            cameraButton.layer.removeAllAnimations()
                    videoFileOutput?.stopRecording()
                }
        
    }
    
}

extension CreateGifMainView: AVCaptureFileOutputRecordingDelegate {
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
        print("Savinging video ...  \(outputFileURL.path)")
//        UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path , nil, nil, nil)
        convertVideoToGIF(outputFileURL)
//        performSegue(withIdentifier: "gifEdit", sender: outputFileURL)
    }
    
    
}

