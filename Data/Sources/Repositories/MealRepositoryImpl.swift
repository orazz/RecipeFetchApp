//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Domain
import Network

public class MealRepositoryImpl: MealRepository {
    
    private var api: Api
    
    public init(api: Api) {
        self.api = api
    }
    
    public func fetchMealList() async throws -> [Domain.Meal] {
        let mealDtoList = try await api.callApi(route: .mealList(params: ["c":"Dessert"]), decodeType: Meals.self)
        
        return mealDtoList.meals.sorted { meal1, meal2 in
            meal1.strMeal < meal2.strMeal
        }
    }
    
    public func fetchMealDetail(idMeal: String) async throws -> Domain.MealDetail {
        let meal = try await api.callApi(route: .mealDetail(params: ["i": idMeal]), decodeType: MealDetailArray.self)
        return meal.meals.first!
    }
}
