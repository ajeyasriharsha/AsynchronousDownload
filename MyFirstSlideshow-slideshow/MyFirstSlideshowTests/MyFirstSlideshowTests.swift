//
//  MyFirstSlideshowTests.swift
//  MyFirstSlideshowTests
//
//  Created by Charles Vu on 17/05/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import XCTest
@testable import MyFirstSlideshow

class MyFirstSlideshowTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testImagesDownloading() {
        for imageUrl in ImageDownloadVC().downloadImages {
            if !imageUrl.isEmpty {
                XCTContext.runActivity(named: "Image: \(imageUrl)") { _ in
                    ImageDownloader().downloadImageForPath(imgPath: imageUrl, completionHandler: { (getImage) in
                        guard let _ = getImage else {
                            XCTFail("Expected a image at this location. This can be failed to downlaod from server.")
                            return
                        }
                    })
                }
            }
            else
            {
                XCTAssertTrue(false, "Empty URL")
            }
        }
    }
    
    
}
