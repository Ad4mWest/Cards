//  CardStatePackage.swift
//  Cards
//  Created by Adam West on 22.01.2024.

import SwiftUI

protocol FileStorageService<TypeData> {
    associatedtype TypeData: Codable
    func saveToStore(forObject object: TypeData) throws
    func loadFromStore() throws -> TypeData
}

extension FileStorageService {
    //MARK: - Defining that we save our data in the Documents folder
    static func persistentFileURL(forStorage nameOfStorage: String) -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return url.appendingPathComponent("\(TypeData.self)\(nameOfStorage).json")
    }
    
    // MARK: Save
    func saveToStore(forObject object: TypeData) throws {
        do {
            let url = Self.persistentFileURL(forStorage: String())
            try JSONEncoder().encode(object).write(to: url)
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
                        contentsOf: Self.persistentFileURL(
                            forStorage: String()
                        )
                    )
                )
        } catch {
            throw APIError.invalidDecoding("Unnabled to decode")
        }
        return object
    }
}
