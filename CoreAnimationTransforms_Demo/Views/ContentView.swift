//
//  ContentView.swift
//  CoreAnimationTransforms_Demo
//
//  Created by Iris on 2025-03-05.
//

import SwiftUI

enum TransformDemoType: String, CaseIterable, Identifiable {
    case translation
    case scale
    case rotation
    case concat
    case invert
    
    var id: String { rawValue }
    var title: String {
        switch self {
        case .translation: return "CATransform3DMakeTranslation"
        case .scale:       return "CATransform3DMakeScale"
        case .rotation:    return "CATransform3DMakeRotation"
        case .concat:      return "CATransform3DConcat"
        case .invert:      return "CATransform3DInvert"
        }
    }
}

struct ContentView: View {
    @State private var selectedDemo: TransformDemoType = .translation
    
    var body: some View {
        NavigationView {
            List(
                TransformDemoType.allCases,
                id: \.self,
                selection: $selectedDemo
            ) { demo in
                Text(demo.title)
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 220)
            
            Group {
                switch selectedDemo {
                case .translation:
                    TranslationDemoView()
                case .scale:
                    ScaleDemoView()
                case .rotation:
                    RotationDemoView()
                case .concat:
                    ConcatDemoView()
                case .invert:
                    InvertDemoView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 900, minHeight: 600)
    }
}

#Preview {
    ContentView()
}
