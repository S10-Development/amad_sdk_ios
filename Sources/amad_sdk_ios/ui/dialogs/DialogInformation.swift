//
//  DialogInformation.swift
//  core
//
//  Created by Pablo Jair Angeles on 06/03/25.
//

public struct DialogInformation{
        var title:String =  Constants.EMPTY_STRING
        var message:String = Constants.EMPTY_STRING
        var onClickButton1: (() -> Void)?
        
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    public init(title: String, message: String,onClickButton1: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.onClickButton1 = onClickButton1
    }
    public init() {
        self.title = Constants.EMPTY_STRING
        self.message =  Constants.EMPTY_STRING
    }
}
