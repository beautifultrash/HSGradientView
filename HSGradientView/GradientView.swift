//
//  GradientView.swift
//  DrawEdgeView
//
//  Created by SongHur on 2017. 5. 3..
//  Copyright © 2017년 SongHur. All rights reserved.
//

import UIKit

@IBDesignable

class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor!
    @IBInspectable var endColor: UIColor!
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
    
    let gradientLayer = CAGradientLayer()
    var animationStartPoint = CAKeyframeAnimation.init(keyPath: "startPoint")
    var animationEndPoint = CAKeyframeAnimation.init(keyPath: "endPoint")
    var revertDirection = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if startColor == UIColor.clear {
            startColor = UIColor(white: 1, alpha: 0)
        }
        
        if endColor == UIColor.clear {
            endColor = UIColor(white: 1, alpha: 0)
        }
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [endColor.cgColor, startColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.addSublayer(gradientLayer)
    }
    
    func beginAnimation(duration: CFTimeInterval, isRevert: Bool) {
        
        
        animationStartPoint = loadPointAnimation(keyframeAnimation: animationStartPoint,
                                                 pointValues: [CGPoint(x: -1.0, y: -1.0),
                                                               CGPoint(x: 1.0, y: 1.0)], duration: duration)
        
        animationEndPoint = loadPointAnimation(keyframeAnimation: animationEndPoint,
                                               pointValues: [CGPoint(x: 0.0, y: 0.0),
                                                             CGPoint(x: 2.0, y: 2.0)], duration: duration)
        
        gradientLayer.add(animationStartPoint, forKey: "startPoint")
        gradientLayer.add(animationEndPoint, forKey: "endPoint")
        revertDirection = isRevert
        
//        if isRevert == true {
//            let view = UIView.init(frame: self.bounds)
//            view.backgroundColor = endColor
//            gradientLayer.addSublayer(view.layer)
////            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
//            
//        } else {
//            let view = UIView.init(frame: self.bounds)
//            view.backgroundColor = startColor
//            gradientLayer.addSublayer(view.layer)
////            gradientLayer.colors = [endColor.cgColor, startColor.cgColor]
//            
//        }

    }
    
    func loadPointAnimation(keyframeAnimation: CAKeyframeAnimation, pointValues: [CGPoint], duration: CFTimeInterval) -> CAKeyframeAnimation {
        
        keyframeAnimation.values = pointValues
        keyframeAnimation.isRemovedOnCompletion = false
        keyframeAnimation.fillMode = kCAFillModeForwards;
        keyframeAnimation.duration = duration
        keyframeAnimation.delegate = self
        
        return keyframeAnimation
    }
}

extension GradientView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}
