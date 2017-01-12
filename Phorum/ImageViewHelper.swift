//
//  ImageViewHelper.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//
import Foundation
import UIKit
import SwiftyGif

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        
        let gifManager = SwiftyGifManager(memoryLimit:20)
        let gif = UIImage(gifName: "loading")
        
        self.setGifImage(gif, manager: gifManager)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            print("Got here")
            gifManager.deleteImageView(self)
            DispatchQueue.main.async() { () -> Void in
                print("Setting image")
                //self.image = nil
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard
            let url = URL(string: link)
            else {
                return
        }
        downloadedFrom(url: url, contentMode: mode)
    }
}
