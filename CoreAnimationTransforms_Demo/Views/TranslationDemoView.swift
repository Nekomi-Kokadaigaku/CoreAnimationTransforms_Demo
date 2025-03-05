//
//  TranslationDemoView.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

struct TranslationDemoView: View {
    // 实际用于动画的参数
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
            value: .double(0.0),
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
            value: .color(.blue)
        )
    ]
    
    // 临时编辑参数
    @State private var draftParameters: [ParameterDescriptor] = []
    
    var body: some View {
        VStack(spacing: 0) {
            DemoLayerView(parameters: parameters) { params in
                let x = params.doubleValue(forKey: "translationX") ?? 0
                let y = params.doubleValue(forKey: "translationY") ?? 0
                return CATransform3DMakeTranslation(CGFloat(x), CGFloat(y), 0)
            }
            .frame(height: 400)
            
            Divider()
            
            HStack {
                ParameterAdjustPanel(parameters: $draftParameters)
                    .frame(width: 350)
                
                Divider()
                
                VStack {
                    Text("说明：此示例使用“应用”按钮才更新动画")
                        .font(.footnote)
                    Spacer()
                    Button("Apply") {
                        parameters = draftParameters
                    }
                    .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 200)
        }
        .onAppear {
            draftParameters = parameters
        }
    }
}
