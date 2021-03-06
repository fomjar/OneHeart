//
//  ViewMain.swift
//  oneheart
//
//  Created by 杜逢佳 on 2017/11/17.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import UIKit
import fcore

class ViewMain: fui.View {
    
    private var pack    : fui.View!
    private var read    : ViewRead!
    private var write   : ViewWrite!
    private var mine    : ViewMine!
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    init() {
        super.init(frame: CGRect())
        self.frameScreen()
        
        self.read = ViewRead()
        self.write = ViewWrite()
        self.mine = ViewMine()
        
        self.pack = fui.packHorizontal([self.mine, self.read, self.write])
        self.pack.toGallery(2)
        self.pack.frame.origin.x = -self.mine.frame.width
        self.addSubview(self.pack)

        self.didShow {
            if !Model.user.valid() {
                let sign = ViewSign()
                sign.show(on: self.superview, style: .coverBottom)
                sign.didHide {self.read.read()}
                return
            }
            
            self.read.read()
        }
    }

}
