//
//  ScaleDemoView.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

struct ScaleDemoView: View {
    @State private var parameters: [ParameterDescriptor] = [
        ParameterDescriptor(
            key: "scaleX",
            label: "Scale X",
            controlType: .slider,
            value: .double(1.5),
            range: 0.1...3.0,
            step: 0.1
        ),
        ParameterDescriptor(
            key: "scaleY",
            label: "Scale Y",
            controlType: .slider,
            value: .double(1.5),
            range: 0.1...3.0,
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
            value: .double(3),
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
            value: .color(.green)
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            DemoLayerView(parameters: parameters) { params in
                let sx = params.doubleValue(forKey: "scaleX") ?? 1.0
                let sy = params.doubleValue(forKey: "scaleY") ?? 1.0
                return CATransform3DMakeScale(CGFloat(sx), CGFloat(sy), 1.0)
            }
            .frame(height: 400)
            
            Divider()
            
            ParameterAdjustPanel(parameters: $parameters)
                .frame(height: 200)
        }
    }
}
