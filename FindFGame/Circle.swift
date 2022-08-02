//
//  Circle.swift
//  FindFGame
//
//  Created by Мария Газизова on 02.08.2022.
//

import UIKit

class Circle {
    private let maskLayer = CAShapeLayer()
    private let center: CGPoint
    private let radius: CGFloat
    
    init(withCenter: CGPoint, andRadius radius: CGFloat) {
        self.center = withCenter
        self.radius = radius
    }
    
    private func circlePath() -> UIBezierPath {
        let rect = CGRect(x: center.x-radius, y: center.y-radius, width: 2 * radius, height: 2 * radius)
        return UIBezierPath(ovalIn: rect)
    }
    
    func display(onView: UIView) {
        let finalPath = UIBezierPath(rect: onView.bounds)
        maskLayer.frame = onView.bounds
        
        finalPath.append(circlePath())
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.path = finalPath.cgPath
        onView.layer.mask = maskLayer
    }
}
