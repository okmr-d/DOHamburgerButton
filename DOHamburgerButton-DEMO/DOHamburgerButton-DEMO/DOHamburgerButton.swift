//
//  DOHamburgerButton.swift
//  DOHamburgerButton
//
//  Created by Daiki Okumura on 2015/07/20.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit

@IBDesignable
public class DOHamburgerButton: UIButton {
    
    var top: CAShapeLayer! = CAShapeLayer()
    var middle: CAShapeLayer! = CAShapeLayer()
    var bottom: CAShapeLayer! = CAShapeLayer()
    
    @IBInspectable public var color: UIColor! = UIColor.blackColor() {
        didSet {
            top.strokeColor = color.CGColor
            middle.strokeColor = color.CGColor
            bottom.strokeColor = color.CGColor
        }
    }
    
    private let topTransform_select = CAKeyframeAnimation(keyPath: "transform")
    private let middleOpacity_select = CAKeyframeAnimation(keyPath: "opacity")
    private let bottomTransform_select = CAKeyframeAnimation(keyPath: "transform")
    
    private let topTransform_deselect = CAKeyframeAnimation(keyPath: "transform")
    private let middleOpacity_deselect = CAKeyframeAnimation(keyPath: "opacity")
    private let bottomTransform_deselect = CAKeyframeAnimation(keyPath: "transform")
    
    override public var selected : Bool {
        didSet {
            updateLayers()
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLayers()
        addTargets()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayers()
        addTargets()
    }
    
    private func createLayers() {
        
        let path: CGPath = {
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 0, 3.5/2)
            CGPathAddLineToPoint(path, nil, 20, 3.5/2)
            return path
        }()
        
        top.path = path
        middle.path = path
        bottom.path = path
        
        for layer in [ top, middle, bottom ] {
            layer.frame = CGRectMake(12, 22 - 3.5 / 2, 20, 3.5)
            layer.fillColor = nil
            layer.strokeColor = UIColor.blackColor().CGColor
            layer.lineWidth = 3.5
            layer.miterLimit = 3.5
            layer.lineCap = kCALineCapSquare
            layer.masksToBounds = true
            layer.actions = ["transform": NSNull(), "opacity": NSNull()]
            self.layer.addSublayer(layer)
        }
        
        updateLayers()
        
        //==============================
        // select animation
        //==============================
        // top animation
        topTransform_select.values = [
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, -7.0, 0.0)),                   //  0/10
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, 1.0, 0.0)),                    //  4/10
            NSValue(CATransform3D: CATransform3DIdentity),                                          //  5/10
            NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),    //  8/10
            NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 4, 0.0, 0.0, 1.0))     // 10/10
        ]
        setCommonProperty(topTransform_select)
        
        // middle animation
        middleOpacity_select.values = [
            1.0,    //  0/10
            1.0,    //  4/10
            0.0,    //  5/10
            0.0,    //  8/10
            0.0     // 10/10
        ]
        setCommonProperty(middleOpacity_select)
        
        // bottom animation
        bottomTransform_select.values = [
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, 7.0, 0.0)),                    //  0/10
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, -1.0, 0.0)),                   //  4/10
            NSValue(CATransform3D: CATransform3DIdentity),                                          //  5/10
            NSValue(CATransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),   //  8/10
            NSValue(CATransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 4, 0.0, 0.0, 1.0))    // 10/10
        ]
        setCommonProperty(bottomTransform_select)
        
        //==============================
        // deselect animation
        //==============================
        // top animation
        topTransform_deselect.values = [
            NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)),                        //  0/10
            NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 4 - CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),    //  4/10
            NSValue(CATransform3D: CATransform3DIdentity),                           //  5/10
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, -9.0, 0.0)),    //  8/10
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, -7.0, 0.0))     // 10/10
        ]
        setCommonProperty(topTransform_deselect)
        
        // middle animation
        middleOpacity_deselect.values = [
            0.0,    //  0/10
            0.0,    //  4/10
            1.0,    //  5/10
            1.0,    //  8/10
            1.0     // 10/10
        ]
        setCommonProperty(middleOpacity_deselect)
        
        // bottom animation
        bottomTransform_deselect.values = [
            NSValue(CATransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)),                        //  0/10
            NSValue(CATransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 4 + CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),    //  4/10
            NSValue(CATransform3D: CATransform3DIdentity),                          //  5/10
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, 9.0, 0.0)),    //  8/10
            NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, 7.0, 0.0))     // 10/10
        ]
        setCommonProperty(bottomTransform_deselect)
    }
    
    private func updateLayers() {
        if (selected) {
            top.transform = CATransform3DMakeRotation(CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)
            middle.opacity = 0.0
            bottom.transform = CATransform3DMakeRotation(-CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)
        } else {
            top.transform = CATransform3DMakeTranslation(0.0, -7.0, 0.0)
            middle.opacity = 1.0
            bottom.transform = CATransform3DMakeTranslation(0.0, 7.0, 0.0)
        }
    }
    
    private func setCommonProperty(animation: CAKeyframeAnimation) {
        animation.duration = 0.3
        animation.keyTimes = [
            0.0,    //  0/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.8,    //  8/10
            1.0     // 10/10
        ]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
    }
    
    private func addTargets() {
        addTarget(self, action: "touchDown:", forControlEvents: UIControlEvents.TouchDown)
        addTarget(self, action: "touchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        addTarget(self, action: "touchDragExit:", forControlEvents: UIControlEvents.TouchDragExit)
        addTarget(self, action: "touchDragEnter:", forControlEvents: UIControlEvents.TouchDragEnter)
        addTarget(self, action: "touchCancel:", forControlEvents: UIControlEvents.TouchCancel)
    }
    
    func touchDown(sender: DOHamburgerButton) {
        layer.opacity = 0.4
    }
    func touchUpInside(sender: DOHamburgerButton) {
        layer.opacity = 1.0
    }
    func touchDragExit(sender: DOHamburgerButton) {
        layer.opacity = 1.0
    }
    func touchDragEnter(sender: DOHamburgerButton) {
        layer.opacity = 0.4
    }
    func touchCancel(sender: DOHamburgerButton) {
        layer.opacity = 1.0
    }
    
    public func select() {
        selected = true
        
        // remove all animations
        top.removeAllAnimations()
        middle.removeAllAnimations()
        bottom.removeAllAnimations()
        
        CATransaction.begin()
        
        top.addAnimation(topTransform_select, forKey: "transform")
        middle.addAnimation(middleOpacity_select, forKey: "opacity")
        bottom.addAnimation(bottomTransform_select, forKey: "transform")
        
        CATransaction.commit()
    }
    
    public func deselect() {
        selected = false
        
        // remove all animations
        top.removeAllAnimations()
        middle.removeAllAnimations()
        bottom.removeAllAnimations()
        
        CATransaction.begin()
        
        top.addAnimation(topTransform_deselect, forKey: "transform")
        middle.addAnimation(middleOpacity_deselect, forKey: "opacity")
        bottom.addAnimation(bottomTransform_deselect, forKey: "transform")
        
        CATransaction.commit()
    }
}
