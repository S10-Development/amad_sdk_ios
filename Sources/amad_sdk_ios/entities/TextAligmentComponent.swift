//
//  TextAligmentComponent.swift
//  core
//
//  Created by Pablo Jair Angeles on 24/09/24.
//

import SwiftUICore


enum TextAligmentComponent: String, Codable,Sendable {
    case MC="MC"//MIDDLE CENTER
    case TS="TS"//TOP START
    case TC="TC"//TOP Centre
    case TE="TE" // TOP END
    case MS="MS"// MIDDLE START
    case ME="ME"// MIDDLE END
    case ES="ES"//End start
    case EC="EC"// end center
    case EE="EE" // End End
    

    
     func getAlignment() -> Alignment {
            switch self {
            case .MC: return .center
            case .TS: return .topLeading
            case .TC: return .top
            case .TE: return .topTrailing
            case .MS: return .leading
            case .ME: return .trailing
            case .ES: return .bottomLeading
            case .EC: return .bottom
            case .EE: return .bottomTrailing
            }
        }
    
    public func getAlignmentGeometryProxy(sizeComponent: SizeComponent,textSize:CGSize,proxy:GeometryProxy) -> CGSize {
        print("=== sizeComponent: \(sizeComponent),textSize: \(textSize), proxy: \(proxy.frame(in: .global).debugDescription)")

     switch self {
     case .TS: return CGSize(width: 0, height: 0)
     case .ES: return CGSize(width: 0, height: sizeComponent.heightToCGFloat()-textSize.height)
     case .MS: return CGSize(width: 0, height: (sizeComponent.heightToCGFloat() / Constants.TWO_CGFLOAT)-(textSize.height/Constants.TWO_CGFLOAT))

     case .TC:  return CGSize(width: (sizeComponent.widthToCGFloat()/Constants.TWO_CGFLOAT)-(textSize.width/Constants.TWO_CGFLOAT)-proxy.frame(in: .global).minX / Constants.TWO_CGFLOAT, height:0)
     case .TE: return CGSize(width: sizeComponent.widthToCGFloat() - textSize.width - proxy.frame(in: .global).minX, height: 0)
     case .ME:  return CGSize(width: sizeComponent.widthToCGFloat() - textSize.width - proxy.frame(in: .global).minX, height: (sizeComponent.heightToCGFloat() / Constants.TWO_CGFLOAT)-(textSize.height/Constants.TWO_CGFLOAT))
     case .MC: return CGSize(width:sizeComponent.widthToCGFloat()/Constants.TWO_CGFLOAT - textSize.width/Constants.TWO_CGFLOAT ,height: sizeComponent.heightToCGFloat()/Constants.TWO_CGFLOAT - textSize.height/Constants.TWO_CGFLOAT)

     case .EC: return CGSize(width: (sizeComponent.widthToCGFloat()/Constants.TWO_CGFLOAT)-(textSize.width/Constants.TWO_CGFLOAT)-proxy.frame(in: .global).minX / Constants.TWO_CGFLOAT, height: sizeComponent.heightToCGFloat()-textSize.height)
     case .EE: return CGSize( width: sizeComponent.widthToCGFloat() - textSize.width - proxy.frame(in: .global).minX, height: sizeComponent.heightToCGFloat()-textSize.height)
     }
 }
}
