//
//  Reord.swift
//  Gif Motion
//
//  Created by martin chibwe on 6/16/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

//Regift constants
let frameCount = 16
let delayTime : Float = 0.2
let loopCount = 0

class Record: UIViewController {
	@IBOutlet weak var gifImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func nextStoryboard(_ sender: Any) {
        
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let gif = UIImage.gif(name: "hotlineBling")
		gifImageView.image = gif
		
	}
}


extension Record: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	
	
	@IBAction func launchVideoCamera(_ sender: AnyObject) {
		
		let recordVideoController = UIImagePickerController()
		
		recordVideoController.sourceType = UIImagePickerControllerSourceType.camera
		recordVideoController.mediaTypes = [kUTTypeMovie as String]
		recordVideoController.allowsEditing = false
		recordVideoController.delegate = self
		
		present(recordVideoController, animated: true, completion: nil)
		
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		let mediaType = info[UIImagePickerControllerMediaType] as! String
		
		if mediaType == kUTTypeMovie  as String {
			let videoURL = info[UIImagePickerControllerMediaURL] as! URL
            print("videoURl \(videoURL)")
			
            convertVideoToGIf(videoURL)
            dismiss(animated: true, completion: nil)
			
		}
		
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
		dismiss(animated: true, completion: nil)
	}
	
	
	
	//GIF conversion method
	func convertVideoToGIf(_ videoURL: URL)  {
        let regift = Regift(sourceFileURL: videoURL, frameCount: frameCount, delayTime: delayTime, loopCount: loopCount)
        let gifURL = regift.createGif()
        
        displayGIF(gifURL!)
        

	}
    
    
	
	func displayGIF(_ url: URL)  {
		let gifEditorVC =
		storyboard?.instantiateViewController(withIdentifier: "GifEditor") as! GifEditor
		gifEditorVC.gifURL = url
		navigationController?.pushViewController(gifEditorVC, animated: true)
       
	}
	
	
	
	
}

