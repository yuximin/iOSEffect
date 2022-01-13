//
//  UIView+Gradient.swift
//  iOSEffect
//
//  Created by apple on 2022/1/12.
//

import Foundation
import UIKit

extension UIView {
    
    static let VIEW_GRADIENT_KEY = "ohla_gradient_layer_key"
    
    // 获取渐变色
    func gradientFetchLayer() -> CAGradientLayer {
        let mark = UIView.VIEW_GRADIENT_KEY
        var gradientLayer = info[mark] as? CAGradientLayer
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer?.frame = bounds
            layer.insertSublayer(gradientLayer!, at: 0)
            info[mark] = gradientLayer
        }
        return gradientLayer ?? CAGradientLayer()
    }
    
    // 设置尺寸
    @discardableResult
    func gradientSize(_ size: CGSize) -> UIView {
        let gradientLayer = gradientFetchLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return self
    }
    
    // 设置坐标
    @discardableResult
    func gradientLocations(_ locations: [Float]) -> UIView {
        let gradientLayer = gradientFetchLayer()
        gradientLayer.locations = locations.map({ (float) -> NSNumber in NSNumber(floatLiteral: Double(float)) })
        return self
    }
    
    // 设置颜色值
    @discardableResult
    func gradientColors(_ colors: [UIColor]) -> UIView {
        let gradientLayer = gradientFetchLayer()
        gradientLayer.colors = colors.map { (color) -> CGColor in color.cgColor }
        return self
    }
    
    // 设置开始点
    @discardableResult
    func gradientStart(_ start: CGPoint) -> UIView {
        let gradientLayer = gradientFetchLayer()
        gradientLayer.startPoint = start
        return self
    }
    
    // 设置结束点
    @discardableResult
    func gradientEnd(_ end: CGPoint) -> UIView {
        let gradientLayer = gradientFetchLayer()
        gradientLayer.endPoint = end
        return self
    }
    
    // 去除渐变色
    @discardableResult
    func removeGradient() -> UIView {
        let gradientLayer = gradientFetchLayer()
        gradientLayer.removeFromSuperlayer()
        info[UIView.VIEW_GRADIENT_KEY] = nil
        return self
    }
    
}

private var key: Void?

extension NSObject {

    var info: [String: Any] {
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            var obj = objc_getAssociatedObject(self, &key) as? [String: Any]
            if obj?.count ?? 0 <= 0 {
                objc_setAssociatedObject(self, &key, [String: Any](), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                obj = objc_getAssociatedObject(self, &key) as? [String: Any]
            }
            return obj!
        }
    }

}
