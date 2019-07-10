//
//  ImageviewExtension.swift
//  MyFirstSlideshow
//
//  Created by Ajeya Sriharsha on 09/07/19.
//  Copyright © 2019 Yoti. All rights reserved.
//

import Foundation
import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    func removeSpinner(onView:UIView){
        let myParent = onView
        for spinner in myParent.subviews{
            spinner.removeFromSuperview()
        }
    }
    
}

class FileManagerHelper
{
    func saveImageDocumentDirectory(name : String,imageData : Data){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func getImage(name : String) -> UIImage?{
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(name)
        if fileManager.fileExists(atPath: imagePAth){
            return UIImage(contentsOfFile: imagePAth)!
        }else{
            print("No Image")
        }
        return nil
    }
}
