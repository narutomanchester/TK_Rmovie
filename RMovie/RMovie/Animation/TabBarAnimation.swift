//
//  TabBarAnimation.swift
//  RMovie
//
//  Created by Hai on 1/2/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import RAMAnimatedTabBarController

class LogoTabBarAnimation: RAMItemAnimation {
    
     override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        self.logoAnimation(icon)
        textLabel.textColor = textSelectedColor
        
    }
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        icon.tintColor = .none
    }
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
        icon.tintColor = defaultIconColor
        
    }
    func logoAnimation (_ icon : UIImageView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}
