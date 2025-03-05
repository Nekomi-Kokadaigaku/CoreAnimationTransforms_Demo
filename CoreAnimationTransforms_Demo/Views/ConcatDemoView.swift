//
//  ConcatDemoView.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

struct ConcatDemoView: View {
    @State private var parameters: [ParameterDescriptor] = [
        ParameterDescriptor(
            key: "translationX",
            label: "Translation X",
            controlType: .slider,
            value: .double(50.0),
            range: 0...150,
            step: 1
        ),
        ParameterDescriptor(
            key: "translationY",
            label: "Translation Y",
            controlType: .slider,
            value: .double(50.0),
            range: 0...150,
            step: 1
        ),
        ParameterDescriptor(
            key: "angle",
            label: "Rotation Angle (radians)",
            controlType: .slider,
            value: .double(Double.pi / 4),
            range: 0...Double.pi * 2,
            step: 0.1
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
            value: .color(.purple)
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            DemoLayerView(parameters: parameters) { params in
                let tx = params.doubleValue(forKey: "translationX") ?? 0.0
                let ty = params.doubleValue(forKey: "translationY") ?? 0.0
                let angle = params.doubleValue(forKey: "angle") ?? 0.0
                let translation = CATransform3DMakeTranslation(CGFloat(tx), CGFloat(ty), 0)
                let rotation = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 1)
                return CATransform3DConcat(translation, rotation)
            }
            .frame(height: 400)
            
            Divider()
            
            ParameterAdjustPanel(parameters: $parameters)
                .frame(height: 200)
        }
    }
}
