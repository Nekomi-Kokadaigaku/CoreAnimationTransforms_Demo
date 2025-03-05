//
//  InvertDemoView.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

struct InvertDemoView: View {
    @State private var parameters: [ParameterDescriptor] = [
        ParameterDescriptor(
            key: "translationX",
            label: "Translation X",
            controlType: .slider,
            value: .double(100.0),
            range: 0...300,
            step: 1
        ),
        ParameterDescriptor(
            key: "translationY",
            label: "Translation Y",
            controlType: .slider,
            value: .double(50.0),
            range: 0...300,
            step: 1
        ),
        ParameterDescriptor(
            key: "duration",
            label: "Duration",
            controlType: .slider,
            value: .double(2.0),
            range: 0.5...5.0,
            step: 0.5
        ),
        ParameterDescriptor(
            key: "autoReverse",
            label: "Auto Reverse",
            controlType: .toggle,
            value: .bool(true)
        ),
        ParameterDescriptor(
            key: "repeatCount",
            label: "Repeat Count",
            controlType: .stepper,
            value: .double(2.0),
            range: 0...10,
            step: 1
        ),
        ParameterDescriptor(
            key: "useKeyframe",
            label: "Use Keyframe",
            controlType: .toggle,
            value: .bool(false)
        ),
        ParameterDescriptor(
            key: "layerColor",
            label: "Layer Color",
            controlType: .colorPicker,
            value: .color(.orange)
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            DemoLayerView(parameters: parameters) { params in
                let tx = params.doubleValue(forKey: "translationX") ?? 0.0
                let ty = params.doubleValue(forKey: "translationY") ?? 0.0
                let transform = CATransform3DMakeTranslation(CGFloat(tx), CGFloat(ty), 0)
                // 使用反转 transform 作为动画目标
                let inverted = CATransform3DInvert(transform)
                return inverted
            }
            .frame(height: 400)
            
            Divider()
            
            ParameterAdjustPanel(parameters: $parameters)
                .frame(height: 200)
        }
    }
}
