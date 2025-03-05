//
//  ParameterDescriptor.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

/// 表示可能的参数值类型
enum ParameterValue: Equatable {
    case double(Double)
    case bool(Bool)
    case text(String)
    case color(Color)  // 支持颜色类型
}

/// 控件类型，用于在 UI 上渲染不同的控件
enum ParameterControlType {
    case slider
    case toggle
    case textField
    case stepper      // 数值微调
    case colorPicker  // 颜色选择器
}

/// 参数描述，用于调节面板动态生成控件
struct ParameterDescriptor: Identifiable, Equatable {
    let id = UUID()
    /// 参数的唯一标识，如 "translationX"
    var key: String
    /// UI 显示的名称
    var label: String
    /// 使用的控件类型
    var controlType: ParameterControlType
    /// 当前参数值
    var value: ParameterValue
    /// 针对数值控件的范围
    var range: ClosedRange<Double>? = nil
    /// 数值控件的步进
    var step: Double? = nil
}

// MARK: - 辅助方法，从参数数组中获取指定类型的值
extension Array where Element == ParameterDescriptor {
    func doubleValue(forKey key: String) -> Double? {
        first(where: { $0.key == key })?.doubleValue
    }
    
    func boolValue(forKey key: String) -> Bool? {
        first(where: { $0.key == key })?.boolValue
    }
    
    func colorValue(forKey key: String) -> Color? {
        first(where: { $0.key == key })?.colorValue
    }
}

extension ParameterDescriptor {
    var doubleValue: Double? {
        if case let .double(d) = self.value { return d }
        return nil
    }
    
    var boolValue: Bool? {
        if case let .bool(b) = self.value { return b }
        return nil
    }
    
    var colorValue: Color? {
        if case let .color(c) = self.value { return c }
        return nil
    }
}
