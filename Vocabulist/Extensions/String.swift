//
//  String.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 24.11.22.
//

import Foundation

extension String {
    
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
