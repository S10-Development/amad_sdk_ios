//
//  InputFieldView.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

import SwiftUI

// MARK: - InputField View
struct InputFieldView: View {
    let title: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            TextField("Ingrese \(title.lowercased())", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }
}
