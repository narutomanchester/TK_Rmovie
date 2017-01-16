//
//  InternetStatus.swift
//  RMovie
//
//  Created by mac on 1/10/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import UIKit
import ReachabilitySwift
import SCLAlertView

class InternetStatus {
    let reachability = Reachability()!
    static let share = InternetStatus()
    
    func checkInternet() ->Bool  {
        if (reachability.isReachable){
            return true
        } else {
            return false
        }
    }
    func showAlert()  {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCircularIcon: true
        )
        let alertView = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "logo Rmovie.png")
        
        alertView.showWarning("Error", subTitle: "Sorry, you're having trouble with the connection. Please try again in a moment.", closeButtonTitle: nil, duration: 1800, colorStyle: UInt(SCLAlertViewStyle.error.hashValue), colorTextButton: 0xFFFFFF, circleIconImage: alertViewIcon, animationStyle: SCLAnimationStyle.rightToLeft)

    }

}
