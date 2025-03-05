//
//  ParameterAdjustPanel.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

struct ParameterAdjustPanel: View {
    @Binding var parameters: [ParameterDescriptor]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(parameters.indices, id: \.self) { i in
                parameterView(for: $parameters[i])
            }
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private func parameterView(for descriptor: Binding<ParameterDescriptor>) -> some View {
        switch descriptor.wrappedValue.controlType {
        case .slider:
            sliderView(descriptor)
        case .toggle:
            toggleView(descriptor)
        case .textField:
            textFieldView(descriptor)
        case .stepper:
            stepperView(descriptor)
        case .colorPicker:
            colorPickerView(descriptor)
        }
    }
    
    /// Slider 控件
    private func sliderView(_ descriptor: Binding<ParameterDescriptor>) -> some View {
        HStack {
            Text(descriptor.wrappedValue.label)
            Spacer()
            if let range = descriptor.wrappedValue.range {
                Slider(
                    value: Binding<Double>(
                        get: { descriptor.wrappedValue.doubleValue ?? 0.0 },
                        set: { newVal in
                            descriptor.wrappedValue.value = .double(newVal)
                        }
                    ),
                    in: range,
                    step: descriptor.wrappedValue.step ?? 0.1
                )
                .frame(width: 150)
                
                Text(String(format: "%.2f", descriptor.wrappedValue.doubleValue ?? 0.0))
                    .frame(width: 50, alignment: .trailing)
            }
        }
    }
    
    /// Toggle 控件
    private func toggleView(_ descriptor: Binding<ParameterDescriptor>) -> some View {
        Toggle(descriptor.wrappedValue.label, isOn: Binding<Bool>(
            get: { descriptor.wrappedValue.boolValue ?? false },
            set: { newVal in
                descriptor.wrappedValue.value = .bool(newVal)
            }
        ))
    }
    
    /// TextField 控件
    private func textFieldView(_ descriptor: Binding<ParameterDescriptor>) -> some View {
        HStack {
            Text(descriptor.wrappedValue.label)
            TextField("", text: Binding<String>(
                get: {
                    if case let .text(t) = descriptor.wrappedValue.value {
                        return t
                    }
                    return ""
                },
                set: { newVal in
                    descriptor.wrappedValue.value = .text(newVal)
                }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    /// Stepper 控件
    private func stepperView(_ descriptor: Binding<ParameterDescriptor>) -> some View {
        HStack {
            Text(descriptor.wrappedValue.label)
            Spacer()
            if let range = descriptor.wrappedValue.range {
                Stepper(
                    value: Binding<Double>(
                        get: { descriptor.wrappedValue.doubleValue ?? 0.0 },
                        set: { newVal in
                            let clamped = min(max(newVal, range.lowerBound), range.upperBound)
                            descriptor.wrappedValue.value = .double(clamped)
                        }
                    ),
                    in: range,
                    step: descriptor.wrappedValue.step ?? 1.0
                ) {
                    Text(String(format: "%.2f", descriptor.wrappedValue.doubleValue ?? 0.0))
                }
            } else {
                Stepper(
                    value: Binding<Double>(
                        get: { descriptor.wrappedValue.doubleValue ?? 0.0 },
                        set: { newVal in
                            descriptor.wrappedValue.value = .double(newVal)
                        }
                    ),
                    step: descriptor.wrappedValue.step ?? 1.0
                ) {
                    Text(String(format: "%.2f", descriptor.wrappedValue.doubleValue ?? 0.0))
                }
            }
        }
    }
    
    /// ColorPicker 控件
    private func colorPickerView(_ descriptor: Binding<ParameterDescriptor>) -> some View {
        HStack {
            Text(descriptor.wrappedValue.label)
            Spacer()
            ColorPicker("", selection: Binding<Color>(
                get: { descriptor.wrappedValue.colorValue ?? .blue },
                set: { newVal in
                    descriptor.wrappedValue.value = .color(newVal)
                }
            ), supportsOpacity: true)
            .labelsHidden()
        }
    }
}
