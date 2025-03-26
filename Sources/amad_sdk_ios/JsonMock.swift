//
//  JsonMock.swift
//  core
//
//  Created by Pablo Jair Angeles on 13/10/24.
//



import Foundation

public class JsonMock {
    public static func parseJSON() -> [Component] {
        let jsonString = """
        [
              {
                "type": 3,
                "UUID": "da2deee5-505e-4b89-a1ef-7a6cf07dda76",
                "actions": {
                  "call": "",
                  "showBySchedule": [
                    {
                      "hourEnd": "6:00 AM",
                      "dayStart": "1",
                      "hourStart": "12:00 AM",
                      "show": true,
                      "dayEnd": "1"
                    }
                  ],
                  "openSections": "",
                  "openWebView": ""
                },
                "properties": {
                  "colorText": "#ababab",
                  "size": {
                    "width": 85,
                    "height": 22
                  },
                  "background": "#8e2f2f",
                  "textAlignment": "ES",
                  "fontSize": 22,
                  "position": {
                    "x": 393,
                    "y": 44
                  },
                  "text": "ASDASS",
                  "cornerRadius": 0
                }
              },
              {
                "type": 3,
                "UUID": "bab0c55c-a5aa-43b5-80b1-ec3489d2f8bc",
                "properties": {
                  "colorText": "#180c0c",
                  "size": {
                    "width": 60,
                    "height": 20
                  },
                  "background": "#ab4949",
                  "textAlignment": "TC",
                  "fontSize": 12,
                  "position": {
                    "x": 345,
                    "y": 94
                  },
                  "text": "Texto1 ",
                  "cornerRadius": 0
                }
              },
              {
                "type": 0,
                "UUID": "90492ed9-f8b9-4a1c-a3bc-ca138c29b2fd",
                "properties": {
                  "size": {
                    "width": 200,
                    "height": 100
                  },
                  "position": {
                    "x": 46,
                    "y": 45
                  },
                  "cornerRadius": 0
                }
              },
              {
                "UUID": "b51123d1-4b0e-4fe6-a616-df36aba09c2d",
                "type": 2,
                "actions": {
                  "call": "",
                  "showBySchedule": [],
                  "openSections": "8ef31919-5ec3-4e10-966e-9e0fd0dc16b3",
                  "openWebView": ""
                },
                "properties": {
                  "margin": {
                    "top": 0,
                    "left": 0,
                    "bottom": 0,
                    "right": 0
                  },
                  "size": {
                    "width": 120,
                    "height": 50
                  },
                  "base64Image": "img.png",
                  "text": "Botón-Imagen",
                  "position": {
                    "x": 49,
                    "y": 116
                  },
                  "cornerRadius": 0
                }
              },
              {
                "type": 4,
                "UUID": "2e8e5886-d9b3-46dc-9fad-bae44a086a0e",
                "actions": {
                  "call": "",
                  "showBySchedule": [],
                  "openSections": "",
                  "openWebView": ""
                },
                "properties": {
                  "itemCarousel": [
                    {
                      "src": "https://media.s10plus.com/amad_manager_2024-05-14_12.13pm.png",
                      "id": "4ef3fa7f-d7d3-4fdb-99a3-e5e7776b7797",
                      "title": "amad_manager_2024-05-14_12.13pm.png"
                    }
                  ],
                  "size": {
                    "width": 300,
                    "height": 250
                  },
                  "position": {
                    "x": 226,
                    "y": 0
                  },
                  "cornerRadius": 0
                }
              }
            ]
        """
        
        // Convertir el string JSON a Data
        guard let jsonData = jsonString.data(using: .utf8) else { return [] }

        do {
            // Decodificar el JSON
            let decoder = JSONDecoder()
            let viewData = try decoder.decode([Component].self, from: jsonData)
            print(viewData)

            return viewData
            // Imprimir el resultado
        } catch {
            print("Error al decodificar JSON: \(error)")
        }
        return []
    }

}
