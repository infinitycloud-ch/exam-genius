// cbtgenius/cbtgenius/Shared/Design/DesignSystem.swift
import SwiftUI

enum DesignSystem {
    enum Colors {
        static let primary = Color("Primary")
        static let background = Color("Background")
        static let text = Color("Text")
    }
    
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    enum FontSize {
        static let title: CGFloat = 24
        static let body: CGFloat = 16
        static let caption: CGFloat = 12
    }
}
