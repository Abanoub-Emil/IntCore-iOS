//
//  RoundedImage.swift
//  IntCoreTask
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.roundUpCorners([.bottomLeft, .bottomRight], radius: 130)
    }
}
extension UIView {
    func roundUpCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
        func applyGradient( locations: [NSNumber]?) -> Void {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [hexStringToUIColor(hex: "#45226b"),hexStringToUIColor(hex: "#4E5F7D")].map { $0.cgColor }
            gradient.locations = locations
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(gradient, at: 0)
    }
    func makeGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        gradientLayer.colors =  [hexStringToUIColor(hex: "#482164"),hexStringToUIColor(hex: "#213345")].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
