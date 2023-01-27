//
//  Loader.swift
//  DJConnect
//
//  Created by mac on 14/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Lottie

public class Loader{
    let window = UIApplication.shared.keyWindow!
    
    var overlayView = UIView(frame: UIScreen.main.bounds)
    
     var loadView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/2 - 30, y: UIScreen.main.bounds.size.height/2 - 30, width: 60, height: 60))
    
    var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
class var shared: Loader {
    struct Static {
        static let instance: Loader = Loader()
    }
    return Static.instance
}
    public func show() {
        
//        do {
//            let gif = try UIImage(gifName: "small_loader.gif")
//            imageView = UIImageView(gifImage: gif)
//            imageView.image = gif
//            imageView.frame = loadView.bounds
//            loadView.addSubview(imageView)
//        } catch {
//            print(error)
//        }
//        imageView.layer.cornerRadius = 25
//        loadView.addSubview(imageView)
//        overlayView.backgroundColor = UIColor .clear
//        overlayView.clipsToBounds = true
//        loadView.alpha = 0.8
//        loadView.backgroundColor = .clear
//        loadView.clipsToBounds = true
//        loadView.layer.cornerRadius = 20
//        overlayView.layer.cornerRadius = 20
//        overlayView.addSubview(loadView)
//        let window = UIApplication.shared.keyWindow!
//            window.addSubview(self.overlayView);
        
        var animationView = AnimationView()
        
        // Create Animation object
        let jsonName = "NewDJLoader"
        let animation = Animation.named(jsonName)

        // Load animation to AnimationView
        animationView = AnimationView(animation: animation)
        //animationView.frame = CGRect(x: self.view.frame.size.width/2, y:  self.view.frame.size.height/2, width: 60, height: 60)
        animationView.frame = loadView.bounds
        animationView.loopMode = .loop
        loadView.addSubview(animationView)
        overlayView.addSubview(loadView)
        let window = UIApplication.shared.keyWindow!
            window.addSubview(self.overlayView);
        //self.view.addSubview(animationView)
       // animationView.isHidden = true
        animationView.play()
        
    }

    public func showWithStatus() {
        
        do {
            let gif = try UIImage(gifName: "small_loader.gif")
            imageView = UIImageView(gifImage: gif)
            imageView.image = gif
            imageView.frame = loadView.bounds
            loadView.addSubview(imageView)
        } catch {
            print(error)
        }
        imageView.layer.cornerRadius = 25
        loadView.addSubview(imageView)
        overlayView.backgroundColor = UIColor .clear
        overlayView.clipsToBounds = true
        loadView.alpha = 0.8
        loadView.backgroundColor = .clear
        loadView.clipsToBounds = true
        loadView.layer.cornerRadius = 20
        overlayView.layer.cornerRadius = 20
        overlayView.addSubview(loadView)
        let window = UIApplication.shared.keyWindow!
            window.addSubview(self.overlayView);
    }
    
    public func hide() {
        DispatchQueue.main.async( execute: {
            self.overlayView.removeFromSuperview()
        })
    }
}
