//
//  InputFieldView.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

import SwiftUI

import SwiftUI


struct InputFieldView: View {
    let title: String
    let isRequired: Bool
    private let rules: [ValidationRule]
    let keyboardType: UIKeyboardType   // ← nuevo parámetro

    @Binding var text: String
    @State private var submitted: Bool = false
    var onValidation: (Bool) -> Void
    @FocusState private var isFocused: Bool   // track focus state

    init(
        title: String,
        text: Binding<String>,
        isRequired: Bool = false,
        keyboardType: UIKeyboardType = .default,    // valor por defecto
        validationBuilder: ((inout ValidationBuilder) -> Void)? = nil,
        onValidation: @escaping (Bool) -> Void = { _ in }
    ) {
        self.title = title
        self._text = text
        self.isRequired = isRequired
        self.keyboardType = keyboardType
        self.onValidation = onValidation
        var builder = ValidationBuilder()
             if let buildRules = validationBuilder {
                 buildRules(&builder)
             }
             self.rules = builder.build()

    }

    /// Evalúa todas las reglas y devuelve `true` sólo si pasan todas.
      private var isValid: Bool {
          if( isRequired){
              rules.allSatisfy { $0.validate(text) }
          }else {
              true
          }
      }
    /// El mensaje de la primera regla que falle (o vacío si todo pasa).
      private var errorMessage: String {
          rules.first(where: { !$0.validate(text) })?.message ?? ""
      }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Título + asterisco
            HStack(spacing: 2) {
                Text(title).font(.headline)
                if isRequired {
                    Text("*").foregroundColor(.red)
                }
            }

            // Campo de texto
            TextField("Ingrese \(title.lowercased())", text: $text)
                .focused($isFocused)   // bind focus
                .padding(10)
                .background(Color(.systemGray6))
                .keyboardType(keyboardType)   
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            (submitted && isRequired && !isValid) ? Color.red : Color.gray,
                            lineWidth: 1
                        )
                )
                .onChange(of: isFocused) { newValue,oldValue in
                    submitted = true
                    onValidation(isValid)
                }
                .onSubmit {
                    submitted = true
                    onValidation(isValid)
                }

            // Mensaje de error ­– distinto según tipo
            if submitted && isRequired && !isValid {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
    }
}
