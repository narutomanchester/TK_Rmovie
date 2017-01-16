//
//  ImageAnimation.swift
//  RMovie
//
//  Created by Hai on 1/6/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit

class ImageAnimation {
    static let share = ImageAnimation()
    
    func animateOn(imageView : UIImageView, view: UIView, imageContainer : UIView, background : UIView) {
        
        UIView.animate(withDuration: 1) {
            imageContainer.frame.origin = view.frame.origin
            imageView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
            imageView.clipsToBounds = false
            for anotherView in view.subviews {
                if anotherView == imageContainer || anotherView == imageView || anotherView == background {
                } else {
                    anotherView.alpha = 0
                }
            }
        }
    }
    func animateOff(imageView : UIImageView, imageContainer : UIView, oldPosition: CGRect, view: UIView, background : UIView ) {
        UIView.animate(withDuration: 1) { 
            imageContainer.frame = oldPosition
            imageView.frame.size = imageContainer.frame.size
            imageView.clipsToBounds = true
            for anotherView in view.subviews {
                if anotherView == imageContainer || anotherView == imageView || anotherView == background  {
                } else {
                    anotherView.alpha = 1
                }
            }
        }
    }
   }
