//
//  GifFilter.swift
//  Gif Motion
//
//  Created by Martin Chibwe on 7/7/17.
//  Copyright © 2017 Martin Chibwe. All rights reserved.
//

import UIKit

class GifFilter: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    var gifVideoFileURL: URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("gifVideoFileURL \(gifVideoFileURL)")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let gifURL = gifVideoFileURL {
            let gifFromRecording = UIImage.gif(url: gifURL.absoluteString)
            gifImageView.image = gifFromRecording
        }
        
//        var gifImage = UIImage.gif(url: "hotlineBling")
//        gifImageView.image =
//        var proofOfConcept = UIImage.gif(name: "hotlineBling")
//        gifImageView.image = proofOfConcept
//        var proofOfConcept = UIImage.gif(url: "hotlineBling")
//        print()
//        gifImageView.image = proofOfConcept
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
