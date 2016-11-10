//
//  ButtonLayer.swift
//  KYButton
//
//  Created by Lawliet on 2016/10/3.
//  Copyright © 2016年 Lawliet. All rights reserved.
//

import UIKit

class ButtonLayer: CAShapeLayer {
    
    
    convenience init(bg:UIColor) {
        self.init()
        self.backgroundColor = bg.cgColor
        self.circleMask()
    }
    
     var plusColor : UIColor = UIColor.black{
        didSet{
            self.strokeColor = plusColor.cgColor
        }
    }
    
    override var frame: CGRect {
        didSet {
            print (self.frame)
            self.drawPlus()
            self.circleMask()
        }
    }
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    fileprivate func  drawPlus() {
        let rect = self.frame
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.midX, y: 15.0))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - 15.0))
        path.move(to: CGPoint(x: 15, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 15,y: rect.midY))
        self.lineWidth = 3
        self.lineCap = kCALineCapRound
        self.strokeColor = plusColor.cgColor
        self.path = path.cgPath
    }
    
    fileprivate func circleMask() {
        let rect = self.frame
        let circlePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: rect.width, height: rect.height), cornerRadius: rect.width)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        self.mask = circleLayer
    }

}
