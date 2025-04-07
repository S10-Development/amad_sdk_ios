//
//  JsonMock.swift
//  core
//
//  Created by Pablo Jair Angeles on 13/10/24.
//



import Foundation

 class JsonMock {
     public static func parseJSON() -> ViewComponent {
        let jsonString = """
         {
                "component": [
                  {
                    "UUID": "afe000d4-b1a9-4aa9-973e-d6a8da88a991",
                    "type": 3,
                    "actions": {
                      "call": "",
                      "showBySchedule": [],
                      "openSections": "",
                      "openWebView": ""
                    },
                    "properties": {
                      "positionImage": "right",
                      "colorText": "#FFFFFF",
                      "itemCarousel": [],
                      "size": {
                        "width": 200,
                        "height": 100
                      },
                      "base64Image": "",
                      "background": "#000000",
                      "textAlignment": "MC",
                      "imageSize": {
                        "width": 10,
                        "height": 10
                      },
                      "position": {
                        "x": 24,
                        "y": 59
                      },
                      "text": "Chiapas Demo 3",
                      "cornerRadius": 0
                    }
                  }
                ],
                "nameView": "Vista 1",
                "id": "a8e3eae1-aa79-4c1b-87ff-de69db83783b",
                "mainView": false,
                "properties": {
                  "background": "#FFFFFF",
                  "width": 405,
                  "scrollable": false,
                  "height": 800
                }
              }
        """
        
        // Convertir el string JSON a Data
         guard let jsonData = jsonString.data(using: .utf8) else { return createDefaultView()}

        do {
            // Decodificar el JSON
            let decoder = JSONDecoder()
            let viewData = try decoder.decode(ViewComponent.self, from: jsonData)
            print(viewData)

            return viewData
            // Imprimir el resultado
        } catch {
            print("Error al decodificar JSON: \(error)")
        }
         return createDefaultView()
    }

}
