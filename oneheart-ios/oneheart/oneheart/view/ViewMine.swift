//
//  ViewMine.swift
//  oneheart
//
//  Created by fomjar on 2017/11/28.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit
import fcore

class ViewMine: fui.View {
    
    private var table: UITableViewController!
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        self.backgroundColor = UIColor.lightGray
        
        table = UITableViewController(style: .plain)
    }
}
