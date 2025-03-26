//
//  Strings.swift
//  core
//
//  Created by Pablo Jair Angeles on 04/02/25.
//

extension Optional where Wrapped == String {
    func isNotNullOrEmpty() -> Bool {
        guard let self = self else { return false }
        return !self.isEmpty
    }
}

extension String {
    public func isNotEmpty() -> Bool {
        return !self.isEmpty
    }
    public func ifEmpty(_ defaultValue: String) -> String {
           return self.isEmpty ? defaultValue : self
       }
}

extension Optional where Wrapped == String {
    public func ifEmptyOrNil(_ defaultValue: String) -> String {
        return (self ?? "").isEmpty ? defaultValue : self!
    }
}

