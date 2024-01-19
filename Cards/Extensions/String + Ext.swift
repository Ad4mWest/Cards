//
//  AddingPercentEncoding.swift
//  Cards
//
//  Created by Adam West on 19.01.2024.
//

import Foundation

extension String {
    func safePercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String? {
        let allowedCharacters = CharacterSet(bitmapRepresentation: allowedCharacters.bitmapRepresentation)
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}
