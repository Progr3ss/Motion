//
//  GifEditor.swift
//  Gif Motion
//
//  Created by martin chibwe on 6/16/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import UIKit

class GifEditor: UIViewController {
	
	var gifURL: URL? = nil
	@IBOutlet weak var gifImageView: UIImageView!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        
		if let gifURL = gifURL {
			let gifFromRecording = UIImage.gif(url: gifURL.absoluteString)
			gifImageView.image = gifFromRecording
		}
	}


}
