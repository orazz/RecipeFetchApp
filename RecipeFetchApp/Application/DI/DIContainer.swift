//
//  DIContainer.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Domain

protocol DIContainer {
    func createMealUseCase() -> MealUseCase
}
