import SwiftUI

// Compatibility wrapper for GlassEffectContainer
struct StikGlassContainer<Content: View>: View {
    var spacing: CGFloat? = nil
    @ViewBuilder var content: () -> Content

    var body: some View {
        if #available(iOS 26.0, *) {
            GlassEffectContainer(spacing: spacing) {
                content()
            }
        } else {
            VStack(spacing: spacing) {
                content()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(24)
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
        }
    }
}

extension View {
    // Compatibility modifier for glassEffect
    @ViewBuilder
    func stikGlassEffect(cornerRadius: CGFloat = 20) -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect(.regular, in: .rect(cornerRadius: cornerRadius))
        } else {
            self.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(.white.opacity(0.15), lineWidth: 0.5)
                )
        }
    }

    @ViewBuilder
    func stikGlassEffectCapsule() -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect(.regular, in: .capsule)
        } else {
            self.background(.ultraThinMaterial, in: Capsule())
                .overlay(
                    Capsule()
                        .stroke(.white.opacity(0.15), lineWidth: 0.5)
                )
        }
    }

    // Compatibility modifier for buttonStyle
    @ViewBuilder
    func stikButtonStyleProminent() -> some View {
        if #available(iOS 26.0, *) {
            self.buttonStyle(.glassProminent)
        } else {
            self.buttonStyle(BorderedProminentButtonStyle())
                .tint(.blue)
        }
    }
}
