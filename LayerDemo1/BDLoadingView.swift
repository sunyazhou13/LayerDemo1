//
//  LoadingView.swift
//  LayerDemo1
//
//  Created by sunyazhou on 16/7/4.
//  Copyright © 2016年 Baidu, Inc. All rights reserved.
//

import Cocoa

class BDLoadingView: NSView {
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let ovalRadius = dirtyRect.size.height/2 * 0.8


        ovalShapeLayer.strokeColor = NSColor.whiteColor().CGColor
        ovalShapeLayer.fillColor = NSColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 7

        ovalShapeLayer.path = CGPathFromNSBezierPath(NSBezierPath(ovalInRect: NSMakeRect(dirtyRect.size.width/2 - ovalRadius, dirtyRect.size.height/2 - ovalRadius, ovalRadius * 2, ovalRadius * 2)))
        ovalShapeLayer.strokeEnd = 0.4 //绘制圆形时只画整个圆形的五分之二，即笔画结束的位置在整个圆形轮廓的五分之二处
        ovalShapeLayer.lineCap = kCALineCapRound //蓝色的部分圆形轮廓两头是圆形
        self.layer?.addSublayer(ovalShapeLayer)
    }
    
//    transform.rotation：旋转动画。
//    transform.ratation.x：按x轴旋转动画。
//    transform.ratation.y：按y轴旋转动画。
//    transform.ratation.z：按z轴旋转动画。
//    transform.scale：按比例放大缩小动画。
//    transform.scale.x：在x轴按比例放大缩小动画。
//    transform.scale.y：在y轴按比例放大缩小动画。
//    transform.scale.z：在z轴按比例放大缩小动画。
//    position：移动位置动画。
//    opacity：透明度动画。
//    duration：动画持续时间。
//    fromValue：动画起始值。
//    toValue：动画结束值。
//    repeatCount：重复次数
    
    func beginSimpleAnimation() {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.duration = 1.5
        rotate.fromValue = 0
        rotate.toValue = -2 * M_PI
        rotate.repeatCount = HUGE
        self.layer!.addAnimation(rotate, forKey: nil)
    }
    
    func beginComplexAnimation()
    {
        let strokeStartAnimate = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimate.fromValue = -0.5
        strokeStartAnimate.toValue = 1
        
        let strokeEndAnimate = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimate.fromValue = 0
        strokeEndAnimate.toValue = 1
        
        let strokeAnimateGroup = CAAnimationGroup()
        strokeAnimateGroup.duration = 1
        strokeAnimateGroup.repeatCount = HUGE
        strokeAnimateGroup.animations = [strokeStartAnimate, strokeEndAnimate]
        ovalShapeLayer.addAnimation(strokeAnimateGroup, forKey: nil)
    }
    
    func CGPathFromNSBezierPath(nsPath: NSBezierPath) -> CGPath! {
        
        if nsPath.elementCount == 0 {
            return nil
        }
        
        let path = CGPathCreateMutable()
        var didClosePath = false
        
        for i in 0...nsPath.elementCount-1 {
            var points = [NSPoint](count: 3, repeatedValue: NSZeroPoint)
            
            switch nsPath.elementAtIndex(i, associatedPoints: &points) {
            case .MoveToBezierPathElement:CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
            break;
            case .LineToBezierPathElement:CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
            break;
            case .CurveToBezierPathElement:CGPathAddCurveToPoint(path, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y)
            break;
            case .ClosePathBezierPathElement:CGPathCloseSubpath(path)
            break;
            didClosePath = true;
            }
        }
        
        if !didClosePath {
            CGPathCloseSubpath(path)
        }
        return CGPathCreateCopy(path)
    }
}
