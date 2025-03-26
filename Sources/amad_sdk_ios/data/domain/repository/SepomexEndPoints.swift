//
//  SepomexEndPoints.swift
//  core
//
//  Created by Pablo Jair Angeles on 17/12/24.
//

enum SepomexEndPoints {
    case GET_STATES
    case GET_MUNICIPALITIES(id:Int)
    case GET_NEIGHBOODS(id:Int)
    
    var value: String {
        switch self {
        case .GET_STATES:
            return "listaTodosEstados"
        case .GET_MUNICIPALITIES(let id):
            return "listaMunicipiosXEstado/\(id)"
        case .GET_NEIGHBOODS(let id ):
            return "listaColoniasXMunicipio/\(id)"
        }
    }
}
