//
//  File.swift
//
//
//  Created by atakishiyev on 11/6/23.
//

import Foundation

public struct MealDetailArray: Decodable {
    public var meals: [MealDetail]
}

public struct MealDetail: Codable {
    public let idMeal: String
    public let strMeal: String
    public let strInstructions: String
    public var ingredientsAndMeasures: [String]
    
    enum CustomCodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strInstructions
    }
    
    struct CustomCodingKeysForIngredientAndMeasure: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = ""
        }
        
        init(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        let ingredientsAndMeasuresContainer = try decoder.container(keyedBy: CustomCodingKeysForIngredientAndMeasure.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        self.ingredientsAndMeasures = []
        
        for i in 1..<20 {
            if let ingredientKey = self.makeKey(for: "strIngredient\(i)"),
               let measureKey = makeKey(for: "strMeasure\(i)"),
               let ingredient = try? ingredientsAndMeasuresContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try? ingredientsAndMeasuresContainer.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.isEmpty {
                let ingredientAndMeasure = "\(measure) \(ingredient)"
                ingredientsAndMeasures.append(ingredientAndMeasure)
            }
        }
    }
    
    
    func makeKey(for key: String) -> CustomCodingKeysForIngredientAndMeasure? {
        return CustomCodingKeysForIngredientAndMeasure(stringValue: key)
    }
}
