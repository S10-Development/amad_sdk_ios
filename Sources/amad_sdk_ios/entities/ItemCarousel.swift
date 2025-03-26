//
//  ItemCarousel.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

// MARK: - ItemCarousel
struct ItemCarousel:Codable,Sendable {
    let  title, src: String
    let id: String
    init(id: String, title: String, src: String) {
        self.id = id
        self.title = title
        self.src = src
    }
}
