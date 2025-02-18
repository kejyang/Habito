//
//  RecipeModel.swift
//  Habito
//
//  Created by Kenneth Yang on 2/17/25.
//

import Foundation

struct RecipeModel: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var img: String
}
