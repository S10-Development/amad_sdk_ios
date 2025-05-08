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
    var component: [Component]
    var header: Header? = Header()
    var footer: Footer? = Footer()
    var properties:PropertiesView
    
    
    init(id: String,
         mainView: Bool,
         nameView: String,
         component: [Component],
         header: Header,
         footer: Footer,
         properties: PropertiesView) {
        self.id = id
        self.mainView = mainView
        self.nameView = nameView
        self.component = component
        self.properties = properties
        self.footer = footer
        self.header = header
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        mainView = try container.decode(Bool.self, forKey: .mainView)
        nameView = try container.decode(String.self, forKey: .nameView)
        component = try container.decode([Component].self, forKey: .component)
        header = try container.decodeIfPresent(Header.self, forKey: .header) ?? createDefaultHeader()
        footer = try container.decodeIfPresent(Footer.self, forKey: .footer) ?? createDefaultFooter()
        properties = try container
            .decodeIfPresent(PropertiesView.self, forKey: .properties)
        ?? PropertiesView.defaultProperties
    }
    
    // … tus propiedades …

    /// Ordena in-place el array `component` por posición (y ascendente, luego x ascendente).
    /// Ordena in-place los componentes solo por su posición y (de menor a mayor).
      mutating func sortComponentsByY() {
          component.sort { lhs, rhs in
              lhs.properties.position.y < rhs.properties.position.y
          }
      }
      
      /// O, si prefieres no mutar, un computed property:
      var componentsSortedByY: [Component] {
          component.sorted {
              $0.properties.position.y < $1.properties.position.y
          }
      }
}

func createDefaultView() -> ViewComponent {
    return ViewComponent(
        id: "1",
        mainView: true,
        nameView: "MainView",
        component: [],
        header: createDefaultHeader(),
        footer: createDefaultFooter(),
        properties:   PropertiesView.defaultProperties
    )
    
    
}
