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
    private var mapper: MealMapper
    
    public init(api: Api) {
        self.api = api
        self.mapper = .init()
    }
    
    public func fetchMealList() async throws -> [Domain.Meal] {
        let mealDtoList = try await api.callApi(route: .mealList(params: ["c":"Dessert"]), decodeType: Meals.self)
        
        let mealList = mapper.mapDtoConvertToEntities(input: mealDtoList.meals)
        return mealList.sorted { meal1, meal2 in
            meal1.strMeal < meal2.strMeal
        }
    }
    
    public func fetchMealDetail(idMeal: String) async throws -> Domain.MealDetail {
        let meal = try await api.callApi(route: .mealDetail(params: ["i": idMeal]), decodeType: MealDetailArray.self)
        return meal.meals.first!
    }
}
