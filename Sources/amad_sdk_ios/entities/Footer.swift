//
//  Footer.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 30/04/25.
//



struct Footer: Codable,Sendable{
    var components: [Component]? = []
    var properties: PropertiesView? = nil
    
    init(components:[Component],properties:Properties?){
        self.components = components
    }
    init(){
        self.components = []
        self.properties = nil
    }
}
func createDefaultFooter() -> Footer {
    return Footer(components: [], properties: nil)
}
