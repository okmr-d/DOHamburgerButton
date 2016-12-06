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
open class DOHamburgerButton: UIButton {
    
    var top: CAShapeLayer! = CAShapeLayer()
    var middle: CAShapeLayer! = CAShapeLayer()
    var bottom: CAShapeLayer! = CAShapeLayer()
    
    @IBInspectable open var color: UIColor! = UIColor.black {
        didSet {
            top.strokeColor = color.cgColor
            middle.strokeColor = color.cgColor
            bottom.strokeColor = color.cgColor
        }
    }
    
    fileprivate let topTransform_select = CAKeyframeAnimation(keyPath: "transform")
    fileprivate let middleOpacity_select = CAKeyframeAnimation(keyPath: "opacity")
    fileprivate let bottomTransform_select = CAKeyframeAnimation(keyPath: "transform")
    
    fileprivate let topTransform_deselect = CAKeyframeAnimation(keyPath: "transform")
    fileprivate let middleOpacity_deselect = CAKeyframeAnimation(keyPath: "opacity")
    fileprivate let bottomTransform_deselect = CAKeyframeAnimation(keyPath: "transform")
    
    override open var isSelected : Bool {
        didSet {
            updateLayers()
        }
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createLayers()
        addTargets()
    }
    
    override public required init(frame: CGRect) {
        super.init(frame: frame)
        createLayers()
        addTargets()
    }
    
    fileprivate func createLayers() {
        
        let path: CGPath = {
            let path = CGMutablePath()
            
            path.move(to: CGPoint(x: 0, y: 3.5/2))
            path.addLine(to: CGPoint(x: 20, y: 3.5/2))
                
            return path
        }()
        
        top.path = path
        middle.path = path
        bottom.path = path
        
        for layer in [ top, middle, bottom ] {
            layer?.frame = CGRect(x: 12, y: 22 - 3.5 / 2, width: 20, height: 3.5)
            layer?.fillColor = nil
            layer?.strokeColor = UIColor.black.cgColor
            layer?.lineWidth = 3.5
            layer?.miterLimit = 3.5
            layer?.lineCap = kCALineCapSquare
            layer?.masksToBounds = true
            layer?.actions = ["transform": NSNull(), "opacity": NSNull()]
            self.layer.addSublayer(layer!)
        }
        
        updateLayers()
        
        //==============================
        // select animation
        //==============================
        // top animation
        topTransform_select.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, -7.0, 0.0)),                   //  0/10
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, 1.0, 0.0)),                    //  4/10
            NSValue(caTransform3D: CATransform3DIdentity),                                          //  5/10
            NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),    //  8/10
            NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 4, 0.0, 0.0, 1.0))     // 10/10
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
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, 7.0, 0.0)),                    //  0/10
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, -1.0, 0.0)),                   //  4/10
            NSValue(caTransform3D: CATransform3DIdentity),                                          //  5/10
            NSValue(caTransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),   //  8/10
            NSValue(caTransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 4, 0.0, 0.0, 1.0))    // 10/10
        ]
        setCommonProperty(bottomTransform_select)
        
        //==============================
        // deselect animation
        //==============================
        // top animation
        topTransform_deselect.values = [
            NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)),                        //  0/10
            NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI) / 4 - CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),    //  4/10
            NSValue(caTransform3D: CATransform3DIdentity),                           //  5/10
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, -9.0, 0.0)),    //  8/10
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, -7.0, 0.0))     // 10/10
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
            NSValue(caTransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)),                        //  0/10
            NSValue(caTransform3D: CATransform3DMakeRotation(-CGFloat(M_PI) / 4 + CGFloat(M_PI) / 3, 0.0, 0.0, 1.0)),    //  4/10
            NSValue(caTransform3D: CATransform3DIdentity),                          //  5/10
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, 9.0, 0.0)),    //  8/10
            NSValue(caTransform3D: CATransform3DMakeTranslation(0.0, 7.0, 0.0))     // 10/10
        ]
        setCommonProperty(bottomTransform_deselect)
    }
    
    fileprivate func updateLayers() {
        if (isSelected) {
            top.transform = CATransform3DMakeRotation(CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)
            middle.opacity = 0.0
            bottom.transform = CATransform3DMakeRotation(-CGFloat(M_PI) / 4, 0.0, 0.0, 1.0)
        } else {
            top.transform = CATransform3DMakeTranslation(0.0, -7.0, 0.0)
            middle.opacity = 1.0
            bottom.transform = CATransform3DMakeTranslation(0.0, 7.0, 0.0)
        }
    }
    
    fileprivate func setCommonProperty(_ animation: CAKeyframeAnimation) {
        animation.duration = 0.3
        animation.keyTimes = [
            0.0,    //  0/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.8,    //  8/10
            1.0     // 10/10
        ]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
    }
    
    fileprivate func addTargets() {
        addTarget(self, action: #selector(DOHamburgerButton.touchDown(_:)), for: UIControlEvents.touchDown)
        addTarget(self, action: #selector(DOHamburgerButton.touchUpInside(_:)), for: UIControlEvents.touchUpInside)
        addTarget(self, action: #selector(DOHamburgerButton.touchDragExit(_:)), for: UIControlEvents.touchDragExit)
        addTarget(self, action: #selector(DOHamburgerButton.touchDragEnter(_:)), for: UIControlEvents.touchDragEnter)
        addTarget(self, action: #selector(DOHamburgerButton.touchCancel(_:)), for: UIControlEvents.touchCancel)
    }
    
    func touchDown(_ sender: DOHamburgerButton) {
        layer.opacity = 0.4
    }
    func touchUpInside(_ sender: DOHamburgerButton) {
        layer.opacity = 1.0
    }
    func touchDragExit(_ sender: DOHamburgerButton) {
        layer.opacity = 1.0
    }
    func touchDragEnter(_ sender: DOHamburgerButton) {
        layer.opacity = 0.4
    }
    func touchCancel(_ sender: DOHamburgerButton) {
        layer.opacity = 1.0
    }
    
    open func select() {
        isSelected = true
        
        // remove all animations
        top.removeAllAnimations()
        middle.removeAllAnimations()
        bottom.removeAllAnimations()
        
        CATransaction.begin()
        
        top.add(topTransform_select, forKey: "transform")
        middle.add(middleOpacity_select, forKey: "opacity")
        bottom.add(bottomTransform_select, forKey: "transform")
        
        CATransaction.commit()
    }
    
    open func deselect() {
        isSelected = false
        
        // remove all animations
        top.removeAllAnimations()
        middle.removeAllAnimations()
        bottom.removeAllAnimations()
        
        CATransaction.begin()
        
        top.add(topTransform_deselect, forKey: "transform")
        middle.add(middleOpacity_deselect, forKey: "opacity")
        bottom.add(bottomTransform_deselect, forKey: "transform")
        
        CATransaction.commit()
    }
}
