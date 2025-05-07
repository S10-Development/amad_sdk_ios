//
//  Header.swift
//  amad_sdk_ios
//
//  Created by Pablo Jair Angeles on 30/04/25.
//

import Foundation


struct Header: Codable,Sendable {
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

func createDefaultHeader() -> Header {
    return Header(components: [], properties: nil)
}
