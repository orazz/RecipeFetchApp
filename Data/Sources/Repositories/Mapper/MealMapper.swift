//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Domain
import Network
import Common

struct MealMapper: Mapper {
    
    typealias Dto = MealDTO
    typealias Entity = Meal
        
    func mapDtoConvertToEntity(input: MealDTO) -> Domain.Meal {
        return .init(idMeal: input.idMeal, strMeal: input.strMeal, strMealThumb: input.strMealThumb)
    }
    
    func mapEntityConvertToDto(input: Meal) -> MealDTO {
        return .init(idMeal: input.idMeal, strMeal: input.strMeal, strMealThumb: input.strMealThumb)
    }
}
