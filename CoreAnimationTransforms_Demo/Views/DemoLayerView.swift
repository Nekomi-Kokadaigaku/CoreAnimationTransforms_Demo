//
//  DemoLayerView.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI
import QuartzCore

struct DemoLayerView: NSViewRepresentable {
    /// 当前的参数数组
    let parameters: [ParameterDescriptor]
    /// 根据参数生成 CATransform3D 的闭包
    let makeTransform: ([ParameterDescriptor]) -> CATransform3D
    
    func makeNSView(context: Context) -> NSView {
        let nsView = NSView(frame: .zero)
        nsView.wantsLayer = true
        nsView.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        // 添加演示图层
        let demoLayer = CALayer()
        demoLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        demoLayer.position = CGPoint(x: 150, y: 150)
        demoLayer.backgroundColor = NSColor.systemBlue.cgColor
        demoLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        nsView.layer?.addSublayer(demoLayer)
        context.coordinator.demoLayer = demoLayer
        
        // 添加初始动画
        applyAnimation(to: demoLayer, parameters: parameters)
        
        return nsView
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        if let demoLayer = context.coordinator.demoLayer {
            applyAnimation(to: demoLayer, parameters: parameters)
        }
    }
    
    /// 根据参数构造动画并添加到图层
    func applyAnimation(to layer: CALayer, parameters: [ParameterDescriptor]) {
        layer.removeAllAnimations()
        
        let transform = makeTransform(parameters)
        let duration = parameters.doubleValue(forKey: "duration") ?? 2.0
        let autoReverse = parameters.boolValue(forKey: "autoReverse") ?? true
        let repeatCount = Float(parameters.doubleValue(forKey: "repeatCount") ?? Double.infinity)
        let useKeyframe = parameters.boolValue(forKey: "useKeyframe") ?? false
        
        // 更新图层颜色（如果设置了）
        if let color = parameters.colorValue(forKey: "layerColor") {
            layer.backgroundColor = NSColor(color).cgColor
        } else {
            layer.backgroundColor = NSColor.systemBlue.cgColor
        }
        
        if useKeyframe {
            let keyframe = CAKeyframeAnimation(keyPath: "transform")
            keyframe.values = [CATransform3DIdentity, transform, CATransform3DIdentity]
            keyframe.keyTimes = [0, 0.5, 1]
            keyframe.duration = duration
            keyframe.autoreverses = false
            keyframe.repeatCount = repeatCount
            layer.add(keyframe, forKey: "keyframeTransform")
        } else {
            let basic = CABasicAnimation(keyPath: "transform")
            basic.fromValue = CATransform3DIdentity
            basic.toValue = transform
            basic.duration = duration
            basic.autoreverses = autoReverse
            basic.repeatCount = repeatCount
            layer.add(basic, forKey: "basicTransform")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var demoLayer: CALayer?
    }
}
