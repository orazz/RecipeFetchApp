//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

public protocol MealRepository {
    func fetchMealList() async throws -> [Meal]
    func fetchMealDetail(idMeal: String) async throws -> MealDetail
}
