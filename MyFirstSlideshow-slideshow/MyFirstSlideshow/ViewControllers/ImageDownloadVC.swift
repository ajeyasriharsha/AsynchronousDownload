//
//  ImageDownloadVC.swift
//  MyFirstSlideshow
//
//  Created by Charles Vu on 17/05/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import UIKit

class ImageDownloadVC: UIViewController {
    let downloadImages: Array<String> = ["https://c1.staticflickr.com/6/5615/15570202337_0e64f5046e_k.jpg",
                                         "https://c1.staticflickr.com/4/3169/2846544061_cb7c04b46f_b.jpg",
                                         "https://i.redd.it/d8q1wkgu1awy.jpg",
                                         "http://www.kapstadt.de/webcam.jpg"]

    var firstDownloadCounter: Int = 0
    var secondDownloadCounter: Int = 0
    @IBOutlet weak var firstdownloadImageView: UIImageView!
    @IBOutlet weak var secondDownloadImageView: UIImageView!
    @IBOutlet var topIndicator: [UIView]?
    @IBOutlet var bottomIndicator: [UIView]?
    
    // MARK: ################## BUTTON ACTIONS #################
    
    @IBAction func onFirstDownloadClicked(_ sender: UIButton) {
        let currentImage = downloadImages[firstDownloadCounter % 4]
        firstDownloadCounter += 1
        
      self.setImage(views: self.topIndicator, downloadingImage: currentImage, downloadingImageView: self.firstdownloadImageView)
    }
    
    @IBAction func onSecondDownloadClicked(_ sender: UIButton) {
        let currentImage = downloadImages[secondDownloadCounter % 4]
        secondDownloadCounter += 1
        self.setImage(views: self.bottomIndicator, downloadingImage: currentImage, downloadingImageView: self.secondDownloadImageView)
    }
    
// MARK ################## CUSTOM METHODS #################

    func setImage(views:[UIView]?,downloadingImage:String, downloadingImageView: UIImageView)
    {
        self.showSpinner(onView: downloadingImageView)
        ImageDownloader().downloadImageForPath(imgPath: downloadingImage) { (downloadedImage)
            in
            DispatchQueue.main.async {
                    downloadingImageView.image = downloadedImage
                    self.removeSpinner(onView: downloadingImageView)
                    if let myViews = views{
                        for ( i, j ) in self.downloadImages.enumerated(){
                            if (downloadingImage == j){
                                myViews[i].backgroundColor = .green
                            }else{
                                myViews[i].backgroundColor = .gray
                            }
                        }
                    }
            }
        }
        
    }
    
}

