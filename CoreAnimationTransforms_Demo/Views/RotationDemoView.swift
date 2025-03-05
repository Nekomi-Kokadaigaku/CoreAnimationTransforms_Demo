//
//  RotationDemoView.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

struct RotationDemoView: View {
    @State private var parameters: [ParameterDescriptor] = [
        ParameterDescriptor(
            key: "angle",
            label: "Angle (radians)",
            controlType: .slider,
            value: .double(Double.pi),
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
            value: .color(.red)
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            DemoLayerView(parameters: parameters) { params in
                let angle = params.doubleValue(forKey: "angle") ?? 0.0
                return CATransform3DMakeRotation(CGFloat(angle), 0, 0, 1)
            }
            .frame(height: 400)
            
            Divider()
            
            ParameterAdjustPanel(parameters: $parameters)
                .frame(height: 200)
        }
    }
}
