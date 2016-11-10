//
//  KYButtonDelegate.swift
//  KYButton
//
//  Created by cuber7788 on 2016/11/10.
//  Copyright © 2016年 Lawliet. All rights reserved.
//

import UIKit


    
@objc protocol KYButtonDelegate  {
    
    @objc optional func closeKYButton(_ button:KYButton)
    @objc optional func openKYButton(_ button:KYButton)
}
