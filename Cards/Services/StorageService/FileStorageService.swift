//  CardStatePackage.swift
//  Cards
//  Created by Adam West on 22.01.2024.

import SwiftUI

protocol FileStorageService<TypeData> {
    associatedtype TypeData
    func saveToStore(toArray array: [TypeData])
    func loadFromStore() -> [TypeData]
}

final class FileStorageServiceImpl<T: Codable>: FileStorageService {
    typealias TypeData = T
    
    // MARK: Private properties
    private var arrayData: [TypeData] = []
    
    //MARK: - Defining that we save our data in the Documents folder
    static func persistentFileURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return url.appendingPathComponent("\(TypeData.self)Array.json")
    }

    // MARK: Save
    func saveToStore(toArray array: [TypeData]) {
        arrayData = array
        do {
            let url = Self.persistentFileURL()
            try JSONEncoder().encode(arrayData).write(to: url)
        } catch {
            assertionFailure(APIError.invalidDecoding("Unnabled to encode").localizedDescription)
        }
    }
    
    // MARK: Load
    func loadFromStore() -> [TypeData] {
        do {
            arrayData = try JSONDecoder().decode([TypeData].self,
                                            from: Data(contentsOf: Self.persistentFileURL()))
        } catch {
            arrayData = []
        }
        return arrayData
    }
}
