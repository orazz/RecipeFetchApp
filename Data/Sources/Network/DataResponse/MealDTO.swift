//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

public struct Meals: Decodable {
    public let meals: [MealDTO]
}

public struct MealDTO: Decodable {
    public let idMeal: String
    public let strMeal: String
    public let strMealThumb: String
    
    public init(idMeal: String, strMeal: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}
