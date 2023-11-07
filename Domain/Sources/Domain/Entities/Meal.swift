//
//  Meal.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/3/23.
//

import Foundation

public struct Meals: Decodable {
    public let meals: [Meal]
}

public struct Meal: Identifiable, Decodable {
    public var id: String {
        idMeal
    }
    public let idMeal: String
    public let strMeal: String
    public let strMealThumb: String
    
    public init(idMeal: String, strMeal: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}
