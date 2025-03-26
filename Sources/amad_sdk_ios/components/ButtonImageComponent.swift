import SwiftUI

struct ButtonImageComponent: View {
    var component: Component
    var onTap: (() -> Void)? // Closure para manejar el clic

    var body: some View {
        Button(action: { onTap?() }) {
            contentView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: component.properties.background ?? Constants.BACKGROUND_COLOR))
        .cornerRadius(component.properties.cornerRadius?.toCGFloat() ?? Constants.ZERO_FLOAT)
    }

    @ViewBuilder
    private func contentView() -> some View {
        switch component.properties.positionImage {
        case .left, .right:
            HStack {
                if component.properties.positionImage == .left { imageView() }
                textView()
                if component.properties.positionImage == .right { imageView() }
            }
        case .top, .bottom:
            VStack {
                if component.properties.positionImage == .top { imageView() }
                textView()
                if component.properties.positionImage == .bottom { imageView() }
            }
        default:
            textView()
        }
    }

    @ViewBuilder
    private func imageView() -> some View {
        if let imageUrl = component.properties.base64Image,
           let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image.resizable()
                    .frame(width: 40, height: 40)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
        }
    }

    private func textView() -> some View {
        Text(component.properties.text ?? Constants.EMPTY_STRING)
            .foregroundStyle(Color(hex: component.properties.colorText ?? Constants.COLOR_TEXT))
    }
}
