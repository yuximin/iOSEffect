//
//  UIView+Gradient.swift
//  iOSEffect
//
//  Created by apple on 2022/1/12.
//

import Foundation
import UIKit

extension UIView {
    private struct RuntimeKey {
        static let gradientLayerKey = UnsafeRawPointer.init(bitPattern: "GradientLayerKey".hashValue)
    }
    
    // 渐变层
    private var gradientLayer: CAGradientLayer? {
        get {
            objc_getAssociatedObject(self, UIView.RuntimeKey.gradientLayerKey!) as? CAGradientLayer
        }
        set {
            objc_setAssociatedObject(self, UIView.RuntimeKey.gradientLayerKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 获取渐变层
    func gradientFetchLayer() -> CAGradientLayer {
        var gradientLayer = self.gradientLayer
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer?.frame = bounds
            layer.insertSublayer(gradientLayer!, at: 0)
            self.gradientLayer = gradientLayer
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
        self.gradientLayer = nil
        return self
    }
    
}
