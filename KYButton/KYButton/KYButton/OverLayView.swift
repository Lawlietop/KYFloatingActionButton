//
//  SubButtonsView.swift
//  KYButton
//
//  Created by cuber7788 on 2016/10/6.
//  Copyright © 2016年 Lawliet. All rights reserved.
//

import UIKit

class OverLayView: UIControl {
    
    
    init() {
        super.init(frame: CGRect.zero)
        self.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
