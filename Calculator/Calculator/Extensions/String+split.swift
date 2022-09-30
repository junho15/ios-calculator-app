//
//  String+split.swift
//  Calculator
//
//  Created by junho lee on 2022/09/21.
//

extension String {
    func split(with target: Character) -> [String] {
        return self.components(separatedBy: "\(target)")
    }
}
