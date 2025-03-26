//
//  View.swift
//  core
//
//  Created by Pablo Jair Angeles on 07/03/25.
//

import SwiftUI
extension View {
   public  func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
