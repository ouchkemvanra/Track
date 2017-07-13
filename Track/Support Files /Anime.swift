//
//  Anime.swift
//  SmartStore
//
//  Created by ty on on 3/16/17.
//  Copyright © 2017 ty on. All rights reserved.
//

import Foundation
import UIKit
protocol Anime {
    //mutating func animate()
    
}
/*enum type: Anime {
 case Button, Text
 mutating func animate() {
 switch self {
 case .Button:
 self = .Button
 break
 case .Text:
 self = .Text
 break
 default:
 self = .Text
 break
 
 }
 }
 }*/
class error: UILabel, Anime{
    
}
class login_text: UITextField, Anime {
    
}
class login_button: UIButton, Anime {
    
}
extension Anime where Self: UIView{
    func flash(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }) { (animationComplete) in
            if animationComplete == true {
                UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                    self.alpha = 0.0
                }, completion: nil)
            }
        }
    }
}
extension Anime where Self: UIView{
    func jitter() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint.init(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint.init(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
