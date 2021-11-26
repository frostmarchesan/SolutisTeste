//
//  CircleLines.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 26/11/21.
//

import UIKit
import CircleLoadingViewPod

class CircleLines: CircleLoadingView {
    
    
    
    func configureCircle(view: UIView, position: Double, width: Double, height: Double, color: CGColor, lineWidth: CGFloat, strokeStart: CGFloat, strokeEnd: CGFloat, speed: Double) -> CircleLoadingView {
        let circle = CircleLoadingView()
        let xFrame = view.frame.width / 2
        let yFrame = view.frame.width / 2
        circle.frame = CGRect(x: xFrame - position, y: yFrame - position, width: width, height: height)
        circle.configureShape(lineColor: color, lineWidth: lineWidth, strokeStart: strokeStart, strokeEnd: strokeEnd, speed: speed)
        return circle
    }
    
    
}
