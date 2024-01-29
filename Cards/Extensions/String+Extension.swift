//  String+Extension.swift
//  Cards
//  Created by Adam West on 19.01.2024.

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    var isValidPhone: Bool {
        let phoneFormat = "^\\d{3}\\d{3}\\d{4}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneFormat)
        return phonePredicate.evaluate(with: self)
    }
    
    var isValidAge: Bool {
        let phoneFormat = "^\\d{2}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneFormat)
        return phonePredicate.evaluate(with: self)
    }
    
    func safePercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String? {
        let allowedCharacters = CharacterSet(bitmapRepresentation: allowedCharacters.bitmapRepresentation)
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}
