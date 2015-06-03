//
//  BlurImage.swift
//  Sociables
//
//  Created by Francis Bailey on 2015-06-02.
//  Copyright (c) 2015 Okanagan College. All rights reserved.
//

import UIKit

class BlurImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        let blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = frame
        effectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        addSubview(effectView)
    }
    
}