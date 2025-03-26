//
//  Application.swift
//  core
//
//  Created by Pablo Jair Angeles on 23/09/24.
//

import Foundation
 struct AppInformation: Codable,Sendable {
    public var appId: String?=""
    public var views: [ViewComponent]
    public var status: Int
    public var preconfiguration: Preconfiguration
    public var personalInformation:PersonalInformationModel? = nil
    
    public func getFirstView() -> [Component] {
        return views.first{$0.mainView}?.component ?? []
    }
    public func getViewByID(_ id: String) -> ViewComponent? {
        return views.first{$0.id == id}
    }
}
