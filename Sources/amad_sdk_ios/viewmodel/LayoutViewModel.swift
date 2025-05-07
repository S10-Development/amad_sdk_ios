//
//  LayoutViewModel.swift
//  core
//
//  Created by Pablo Jair Angeles on 16/02/25.
//

import Combine
import CoreGraphics

 class LayoutViewModel: ViewModelBase{
    
      var view: ViewComponent = createDefaultView()
     @Published var navigateOtherView: Bool = false
     
}
