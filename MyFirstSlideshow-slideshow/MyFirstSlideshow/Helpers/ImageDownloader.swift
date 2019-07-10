//
//  ImageDownloader.swift
//  MyFirstSlideshow
//
//  Created by Ajeya Sriharsha on 10/07/19.
//  Copyright © 2019 Yoti. All rights reserved.
//

import Foundation
typealias ImageDownloaded = ((UIImage?) -> ())

import Foundation
import UIKit
class ImageDownloader {
    
    var task: URLSessionDataTask!
    var session: URLSession!
    var imagesBeingDownloaded: [String] = [String]()
    var noImages: [String] = [String]()
    
    init() {
        
        // Data task initialisation with session
        session = URLSession.shared
        task = URLSessionDataTask()
    }
    func downloadImageForPath(imgPath: String, completionHandler: @escaping ImageDownloaded) {
        let imgName = (imgPath as NSString).lastPathComponent
        if let image = FileManagerHelper().getImage(name: imgName){
            DispatchQueue.main.async {
                print("Image loaded from cache for path : \(imgPath)")
                completionHandler(image)
            }
        }
        else
        {
            if(!noImages.contains(imgPath)){
                let url: URL! = URL(string: imgPath)
                print("Start Image downloading for path : \(imgPath)");
                imagesBeingDownloaded.append(imgPath)
                task = session.dataTask(with: url, completionHandler: { (imageData, response, error) in
                    if let data = imageData {
                        print("Image downloaded for path : \(imgPath)");
                        self.imagesBeingDownloaded.remove(at: self.imagesBeingDownloaded.index(of: imgPath)!)
                        let img: UIImage! = UIImage(data: data)
                        FileManagerHelper().saveImageDocumentDirectory(name: imgName, imageData: data)
                        DispatchQueue.main.async {
                            completionHandler(img)
                        }
                    }
                    else{
                        self.imagesBeingDownloaded.remove(at: self.imagesBeingDownloaded.index(of: imgPath)!)
                        self.noImages.append(imgPath)
                        DispatchQueue.main.async {
                            let placeholder = #imageLiteral(resourceName: "ComingSoon")
                            completionHandler(placeholder)
                        }
                    }
                })
                task.resume()
            }
            else
            {
                let placeholder = #imageLiteral(resourceName: "ComingSoon")
                completionHandler(placeholder)
            }
        }
    }
}
