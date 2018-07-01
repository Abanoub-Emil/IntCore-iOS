//
//  RoundedBottom.swift
//  IntCoreTask
//
//  Created by Admin on 7/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class BezierCurveView: UIView {
    
    private var bottomConstrainConstant: CGFloat = 0
    
    // MARK: - Outlets
//    @IBOutlet weak var mapButton: RoundedRectButton!
//    @IBOutlet weak var toursButton: RoundedRectButton!
//    @IBOutlet weak var bookButton: RoundedRectButton!
    
    @IBOutlet weak var bottomMapButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomBookButtonConstraint: NSLayoutConstraint!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let imageViewHeight = self.bounds.height - 40
        
        let pointsForCurve = calculateCurvePointsFor(viewHeight: imageViewHeight)
        let controlPoint = CGPoint(x: self.bounds.width / 2, y: imageViewHeight)
        let curveControlPoint = calculateCurveControlPointFor(startPoint: pointsForCurve[0], endPoint: pointsForCurve[1], controlPoint: controlPoint)
        
        let path = UIBezierPath()
        path.move(to: pointsForCurve[0])
        path.addQuadCurve(to: pointsForCurve[1], controlPoint: curveControlPoint)
        path.addLine(to: CGPoint(x: self.bounds.width, y: imageViewHeight))
        path.addLine(to: CGPoint(x: 0.0, y: imageViewHeight))
        path.close()
        
        // Specify the fill color and apply it to the path.
//        ColorHelper.bckgDefaultBlue.setFill()
        path.fill()
    }
    
    private func calculateCurvePointsFor(viewHeight: CGFloat) -> [CGPoint] {
        // Using Pythagorean theorem, calculate start and end point for curve
        
        let squaredLegA = pow(self.bounds.width / 2, 2)
        let squaredHypotenuse = pow(viewHeight, 2)
        
        let legB = sqrt(squaredHypotenuse - squaredLegA)
        
        // 0.6  - proportion (button position)
        // 40   - button radius
        bottomConstrainConstant = ((self.bounds.height - legB) * 0.6) - 40
        bottomMapButtonConstraint.constant = bottomConstrainConstant
        bottomBookButtonConstraint.constant = bottomConstrainConstant
        
        let startPoint = CGPoint(x: 0, y: legB)
        let endPoint = CGPoint(x: self.bounds.width, y: legB)
        
        return [startPoint, endPoint]
    }
    
    private func calculateCurveControlPointFor(startPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint) -> CGPoint {
        // Using Bezier curve algorithm
        // P(t) = P0*t^2 + P1*2*t*(1-t) + P2*(1-t)^2
        // t = 0.5
        //        Pc = P0*.25 + P1*2*.25 + P2*.25
        //        P1 = (Pc - P0*.25 - P2*.25)/.5
        //            = 2*Pc - P0/2 - P2/2
        // Px -  points to path through
        
        let controlPointX = calculateHalfCurveControlPoint(startHalfPoint: startPoint.x, endHalfPoint: endPoint.x, controlHalfPoint: controlPoint.x)
        let controlPointY = calculateHalfCurveControlPoint(startHalfPoint: startPoint.y, endHalfPoint: endPoint.y, controlHalfPoint: controlPoint.y)
        
        return CGPoint(x: controlPointX, y: controlPointY)
    }
    
    private func calculateHalfCurveControlPoint(startHalfPoint: CGFloat, endHalfPoint: CGFloat, controlHalfPoint: CGFloat) -> CGFloat {
        return 2 * controlHalfPoint - startHalfPoint / 2 - endHalfPoint / 2
    }
}
