//
//  CircleLoadingView.swift
//  CircleLoadingViewPod
//
//  Created by marcelo frost marchesan on 24/11/21.
//

import UIKit

open class CircleLoadingView: UIView {
    
    let spinningCircle = CAShapeLayer()
    private var isRotatingFinished = false
    
    public func configureFrame(frame: CGRect) {
        spinningCircle.frame = frame
    }
    
    public func configureShape(lineColor: CGColor = UIColor.blue.cgColor, lineWidth: CGFloat = 8, strokeStart: CGFloat = 0, strokeEnd: CGFloat = 0.25, speed: Double) {
        isRotatingFinished = false
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.lineCap = .round
        spinningCircle.strokeColor = lineColor
        spinningCircle.lineWidth = lineWidth
        spinningCircle.strokeStart = strokeStart
        spinningCircle.strokeStart = strokeStart
        spinningCircle.strokeEnd = strokeEnd
        self.layer.addSublayer(spinningCircle)
        animate(speed: speed)
    }
    
    private func animate(speed: Double) {
        if (isRotatingFinished) {
            return
        } else {
            UIView.animate(withDuration: speed, delay: 0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(rotationAngle: .pi) }) { (completed) in
                    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: { self.transform = CGAffineTransform(rotationAngle: 0) }) { (completed) in
                            self.animate(speed: speed)
                    }
                }
        }
    }
    
    public func stopAnimation() {
        isRotatingFinished = true
    }

}
