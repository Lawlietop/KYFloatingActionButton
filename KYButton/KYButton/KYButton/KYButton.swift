//
//  KYButton.swift
//  KYButton
//
//  Created by Lawliet on 2016/10/3.
//  Copyright © 2016年 Lawliet. All rights reserved.
//

import UIKit
@IBDesignable
class KYButton: UIView{


     enum openButtonType {
        case slideUp
        case slideDown
        case popUp
        case popDown
    }

    
    /*
    // Only override draw() if you perform custom drawing./Users/cuber7788/kybutton/KYButton/KYButton.xcodeproj
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var kyDelegate:KYButtonDelegate?
    
    var hilighColor : UIColor!
    var orignalColor : UIColor!
    var overLayView : OverLayView!
    
    var buttonLayer : ButtonLayer?
    var isHide : Bool = true
    
    var openType : openButtonType = .popUp
    
    var buttonCells : KYButtonCells?
    
    var items : [KYButtonCells] = []
    
    
    var plusColor:UIColor = UIColor.black{
        didSet{
            buttonLayer?.plusColor = plusColor
        }
    }
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
        backgroundColor = UIColor.orange
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buttonLayer = ButtonLayer.init(bg: self.backgroundColor!)
        orignalColor = self.backgroundColor
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.addSublayer(buttonLayer!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var intrinsicContentSize: CGSize{
            return CGSize(width: 55, height: 55)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonLayer?.frame = self.bounds
        self.invalidateIntrinsicContentSize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hilighColor = orignalColor
        buttonLayer?.backgroundColor = hilighColor.white(rate: 0.7).cgColor
    }
 
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
                if (self.isHide) {
                    self.openButton()
                }else{
                    self.closeButton()
                }
        
        buttonLayer?.backgroundColor = orignalColor.cgColor
    }
    
    
    
   fileprivate func openButton() {
    
    self.isHide = false
    self.overLayView = OverLayView()
    self.superview?.insertSubview(self.overLayView, belowSubview:self)
    
    overLayView.addTarget(self, action: #selector(KYButton.closeButton), for: .touchUpInside)
    
    
    UIView.animate(withDuration: 0.3) {
    self.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_4), 0.0, 0.0, 1)
    self.overLayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    
    
    for item in items {
        self.overLayView.addSubview(item)
    }
    
    switch openType {
    case .slideUp:
        self.slideUpAnimation(isShow: true)
    case .slideDown:
        slideDownAnimation(isShow: true)
    case .popUp:
        popAnimation(isShow: true)
    case .popDown:
        popDownAnimation(isShow: true)
        }
    
    self.kyDelegate?.openKYButton?(self)
    
    }
    
    func closeButton() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.transform = CATransform3DMakeRotation(0, 0.0, 0.0, 1)
            self.overLayView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            })
        
        
        switch openType {
        case .slideUp:
            slideUpAnimation(isShow: false)
        case .slideDown:
            slideDownAnimation(isShow: false)
        case .popUp:
            popAnimation(isShow: false)
        case .popDown:
            popDownAnimation(isShow: false)
        }
        
        
        self.kyDelegate?.closeKYButton?(self)
    }
    
    open func add(color:UIColor) {
        let item = KYButtonCells()
        item.buttonItemColor = color
        item.backgroundColor = UIColor.clear
        item.alpha = 0
        item.actionButton = self
        items.append(item)
    }
    
    open func add(color:UIColor,image:UIImage,handle:@escaping ((KYButtonCells)->Void)){
        let item = KYButtonCells()
        item.buttonItemColor = color
        item.icon = image
        item.backgroundColor = UIColor.clear
        item.alpha = 0
        item.actionCloure = handle
        item.actionButton = self
        items.append(item)
    }
    
    
    
//    ----------------------------------------------slideUp---------------------------------------------------
    
    
    fileprivate func slideUpAnimation(isShow:Bool) {
    
        var delay = 0.0
        if isShow {
        for (index,item) in items.enumerated() {
            
            item.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y - self.frame.height * CGFloat(index), width: self.frame.width, height: self.frame.height)
            
            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: {
                let shift = self.frame.height
                item.transform = CGAffineTransform.init(translationX: 0, y:  -shift)
                item.alpha = 1
                }, completion: nil)
            delay += 0.15
            }
        }else {
            for (index,item) in items.reversed().enumerated(){
                
            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: {
                item.transform = CGAffineTransform.identity
                item.alpha = 0
                    }, completion: { (finish) in
                        if index == self.items.count-1 && !isShow{
                            self.isHide = true
                            self.overLayView.removeFromSuperview()
                        }
                    })
                delay += 0.15
            }
        }
    }
    
    
    
//    ----------------------------------------------slideDown---------------------------------------------------
    
    
   fileprivate func slideDownAnimation(isShow:Bool) {
        
        var delay = 0.0
        if isShow {
            for (index,item) in items.enumerated() {
                item.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height * CGFloat(index), width: self.frame.width, height: self.frame.height)
                
                UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: {
                    let shift = self.frame.height
                    item.transform = CGAffineTransform.init(translationX: 0, y:  shift)
                    item.alpha = 1
                    }, completion: nil)
                delay += 0.15
            }
        }else {
            for (index,item) in items.reversed().enumerated(){
                
                UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: {
                    item.transform = CGAffineTransform.identity
                    item.alpha = 0
                    }, completion: { (finish) in
                        if index == self.items.count-1 && !isShow{
                            self.isHide = true
                            self.overLayView.removeFromSuperview()
                        }
                })
                delay += 0.15
                }
            }
        }
    
    
//    ----------------------------------------------pop---------------------------------------------------
    
   fileprivate func popAnimation(isShow:Bool) {
        var delay = 0.0
        if isShow{
            for (index,item) in items.enumerated() {
                item.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y - self.frame.height * CGFloat(index+1), width: self.frame.width, height: self.frame.height)
                item.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
                UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: {
                    item.transform = CGAffineTransform.identity
                    item.alpha = 1
                    }, completion: nil)
                delay += 0.15
            }
        }else{
            for (index,item) in items.reversed().enumerated(){
                UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
                    
                    item.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                    item.alpha = 0
                    }, completion: { (finish) in
                        if index == self.items.count-1 && !isShow{
                            self.isHide = true
                            self.overLayView.removeFromSuperview()
                        }
                        item.transform = CGAffineTransform.identity
                })
                delay += 0.15
            }
        }
    }
    
    
    //    ----------------------------------------------popDown---------------------------------------------------
    
    fileprivate func popDownAnimation(isShow:Bool) {
        var delay = 0.0
        if isShow{
            for (index,item) in items.enumerated() {
                item.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height * CGFloat(index+1), width: self.frame.width, height: self.frame.height)
                item.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
                UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: {
                    item.transform = CGAffineTransform.identity
                    item.alpha = 1
                }, completion: nil)
                delay += 0.15
            }
        }else{
            for (index,item) in items.reversed().enumerated(){
                UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
                    
                    item.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                    item.alpha = 0
                }, completion: { (finish) in
                    if index == self.items.count-1 && !isShow{
                        self.isHide = true
                        self.overLayView.removeFromSuperview()
                    }
                    item.transform = CGAffineTransform.identity
                })
                delay += 0.15
            }
        }
    }
}
