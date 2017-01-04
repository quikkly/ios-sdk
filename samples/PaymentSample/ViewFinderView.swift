//
//  ViewFinderView.swift
//  Samples
//
//  Created by Julian Gruber on 13/01/2017.
//  Copyright © 2017 Quikkly Ltd. All rights reserved.
//

import UIKit

class ViewFinderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let lineWidth:CGFloat = 3
        let size:CGFloat = 35
        let inset = lineWidth*0.5
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        path.move(to: CGPoint(x:inset, y:size))
        path.addQuadCurve(to: CGPoint(x:size, y:inset), controlPoint: CGPoint(x:inset, y:inset))
        
        path.move(to: CGPoint(x:rect.size.width-size, y:inset))
        path.addQuadCurve(to: CGPoint(x:rect.size.width-inset, y:size), controlPoint: CGPoint(x:rect.size.width-inset, y:inset))
        
        path.move(to: CGPoint(x:rect.size.width-inset, y:rect.size.height-size))
        path.addQuadCurve(to: CGPoint(x:rect.size.width-size, y:rect.size.height-inset), controlPoint: CGPoint(x:rect.size.width-inset, y:rect.size.height-inset))
        
        path.move(to: CGPoint(x:size, y:rect.size.height-inset))
        path.addQuadCurve(to: CGPoint(x:inset, y:rect.size.height-size), controlPoint: CGPoint(x:inset, y:rect.size.height-inset))
        
        UIColor.white.setStroke()
        path.stroke()
    }
    
}
