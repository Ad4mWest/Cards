//  CardStatePackage.swift
//  Cards
//  Created by Adam West on 22.01.2024.

import SwiftUI

protocol FileStorageService<TypeData> {
    associatedtype TypeData: Codable
    func saveToStore(forObject object: TypeData) throws
    func loadFromStore() throws -> TypeData
}

final class FileStorageServiceImpl<TypeData: Codable>: FileStorageService {
    // MARK: Private properties
    private var nameOfStorage: String
    private var logingService: LoggingService
    
    // MARK: Initialization
    init(
        nameOfStorage: String,
        logingService: LoggingService
    ) {
        self.nameOfStorage = nameOfStorage
        self.logingService = logingService
    }
    
    //MARK: - Defining that we save our data in the Documents folder
    private func persistentFileURL(forStorage nameOfStorage: String) -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return url.appendingPathComponent("\(TypeData.self)\(nameOfStorage).json")
    }
    
    // MARK: Save
    func saveToStore(forObject object: TypeData) throws {
        do {
            let url = persistentFileURL(forStorage: nameOfStorage)
            try JSONEncoder().encode(object).write(to: url)
            logingService.logWrite()
        } catch {
            throw APIError.invalidDecoding("Unnabled to encode")
        }
    }
    
    // MARK: Load
    func loadFromStore() throws -> TypeData {
        let object: TypeData
        do {
            object = try JSONDecoder()
                .decode(
                    TypeData.self, from: Data(
                        contentsOf: persistentFileURL(
                            forStorage: nameOfStorage
                        )
                    )
                )
            logingService.logRead()
        } catch {
            throw APIError.invalidDecoding("Unnabled to decode")
        }
        return object
    }
    
    // MARK: Clear persistent storage
    func clearPersistentStorage() {
        let url = persistentFileURL(forStorage: nameOfStorage)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Impossible to clear storage.")
        }
    }
}
