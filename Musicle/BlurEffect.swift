//
//  BlurEffect.swift
//  Musicle
//
//  Created by Elamr Imanov on 9/25/22.
//

import Foundation
import SwiftUI
struct Blur : UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
