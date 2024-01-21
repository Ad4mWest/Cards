//  StatePackage.swift
//  Cards
//  Created by Adam West on 21.01.2024.

import SwiftUI

//protocol StatePackage {
//    associatedtype T where T: Codable
//    var data: T { get set }
//    func saveToStore()
//    func loadFromStore()
//}

final class StatePackageImpl<T: Codable>: ObservableObject { //, StatePackage {
    typealias TypeData = T
    
    // MARK: Public Properties
    @Published var data: TypeData
    
    // MARK: Initialization
    init(data: TypeData) {
        self.data = data
    }
    
    //MARK: - Defining that we save our data in the Documents folder
    static func persistentFileURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return url.appendingPathComponent("Card.json")
    }

    // MARK: Save
    func saveToStore() {
        do {
            let url = Self.persistentFileURL()
            try JSONEncoder().encode(data).write(to: url)
        } catch {
            assertionFailure("Can't be Saved")
        }
    }
    
    // MARK: Load
    func loadFromStore() {
        do {
            data = try JSONDecoder().decode(TypeData.self,
                                            from: Data(contentsOf: Self.persistentFileURL()))
        } catch {
            print("Can't be Loaded")
            //data = Card() as! T
        }
    }
}
