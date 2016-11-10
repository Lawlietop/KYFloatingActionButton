
//
//  UIColorExtension.swift
//  KYButton
//
//  Created by cuber7788 on 2016/10/5.
//  Copyright © 2016年 Lawliet. All rights reserved.
//
import Foundation
import UIKit

extension UIColor{
 
    var reded : CGFloat {
        get {
            let components = self.cgColor.components
            return components![0]
        }
    }
    
    var greened : CGFloat{
        get {
            let components = self.cgColor.components
            return components![1]
        }
    }
    
    var blued : CGFloat{
        get {
            let components = self.cgColor.components
            return components![2]
        }
    }
    
    
    var alpha : CGFloat{
        get{
            return self.cgColor.alpha
        }
    }
    
    func alpha(alpha: CGFloat) -> UIColor {
        return UIColor(red: self.reded, green: self.greened, blue: self.blued, alpha: alpha)
    }
    
    func white(rate: CGFloat) -> UIColor {
        return UIColor(
            red: self.reded + (1.0 - self.reded) * rate,
            green: self.greened + (1.0 - self.greened) * rate,
            blue: self.blued + (1.0 - self.blued) * rate,
            alpha: 1.0
        )
    }
    
}
