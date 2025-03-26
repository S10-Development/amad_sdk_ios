//
//  AudioDownloadManager.swift
//  core
//
//  Created by Pablo Jair Angeles on 13/10/24.
//

import Foundation

final class AudioDownloadManager {
    @MainActor static let shared = AudioDownloadManager()
    
    // Directorio donde se guardará el archivo
    private let audioDirectory: URL

    private init() {
        // Obtén el directorio de documentos de la app
        audioDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    // Descarga un archivo de audio desde la URL proporcionada y lo guarda localmente
    func downloadAudio(from urlString: String, withFileName fileName: String) async throws -> URL {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        // Usa URLSession para descargar el archivo
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Genera la ruta donde se guardará el archivo
        let fileURL = audioDirectory.appendingPathComponent(fileName)
        
        // Guarda los datos del audio en la ubicación especificada
        try data.write(to: fileURL)

        return fileURL
    }

    // Verifica si un archivo existe
    func fileExists(withFileName fileName: String) -> Bool {
        let fileURL = audioDirectory.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: fileURL.path)
    }

    // Elimina un archivo guardado localmente
    func deleteAudio(withFileName fileName: String) throws {
        let fileURL = audioDirectory.appendingPathComponent(fileName)
        try FileManager.default.removeItem(at: fileURL)
    }

    // Obtiene la URL de un archivo de audio guardado localmente
    func getLocalAudioURL(withFileName fileName: String) -> URL? {
        let fileURL = audioDirectory.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: fileURL.path) ? fileURL : nil
    }
}
