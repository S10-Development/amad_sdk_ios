//
//  View.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

import CoreGraphics

public struct ViewComponent :Codable,Sendable{
    let id: String
    let mainView: Bool
    let nameView: String
    let component: [Component]
    var properties:PropertiesView
    
    
     init(id: String, mainView: Bool, nameView: String, component: [Component], properties: PropertiesView) {
        self.id = id
        self.mainView = mainView
        self.nameView = nameView
        self.component = component
        self.properties = properties
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        mainView = try container.decode(Bool.self, forKey: .mainView)
        nameView = try container.decode(String.self, forKey: .nameView)
        component = try container.decode([Component].self, forKey: .component)
        // Aquí es donde asignas el valor por defecto si properties es nil:
        properties = try container.decodeIfPresent(PropertiesView.self, forKey: .properties)
        ?? PropertiesView.defaultProperties
    }
}

func createDefaultView() -> ViewComponent {
    return ViewComponent(id: "1", mainView: true, nameView: "MainView", component: [],
                         properties:   PropertiesView.defaultProperties)
}
