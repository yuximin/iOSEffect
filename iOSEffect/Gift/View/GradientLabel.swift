//
//  GradientLabel.swift
//  iOSEffect
//
//  Created by apple on 2022/1/12.
//

import UIKit

class GradientLabel: UILabel {
    
    // 解决设置斜体时文本左右内容被切显示不全问题
    private let GUTTER = 4.0
    
    var colors: [UIColor]?
    
    override func draw(_ rect: CGRect) {
        var newRect = rect
        newRect.origin.x = rect.origin.x + GUTTER
        newRect.size.width = rect.size.width - 2 * GUTTER
        super.drawText(in: newRect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        guard let textMask = context.makeImage() else {
            return
        }

        // 清空画布
        context.clear(rect)

        context.translateBy(x: 0.0, y: rect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: rect, mask: textMask)

        // 绘制渐变
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [1.0, 0.0]
        
        var cgColors = [CGColor]()
        if let colors = colors {
            cgColors = colors.map { $0.cgColor }
        }

        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            return
        }

        let startPoint = CGPoint(x: 0, y: self.bounds.height / 2.0)
        let endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height / 2.0)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: GUTTER, bottom: 0, right: GUTTER)
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += 2 * GUTTER
        return size
    }
    
    func showAnimation(_ completion: (() -> Void)? = nil) {
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
        }) { _ in
            self.transform = .identity
            completion?()
        }
    }

}
