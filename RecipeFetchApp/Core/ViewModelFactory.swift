//
//  ViewModelFactory.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

class ViewModelFactory {
    
    private var container: DIContainer!
    
    static let shared = ViewModelFactory()
    
    private init() {}
    
    func register(DIContainer container: DIContainer) {
        self.container = container
    }

    func checkContainerCreated() {
        guard container != nil else {
            fatalError("Register DIContainer to Enable ViewModel Creation")
        }
    }
    
    func createMealViewModel() -> MealViewModel {
        checkContainerCreated()
        let mealUseCase = container.createMealUseCase()
        return .init(mealUseCase: mealUseCase)
    }
    
    func createMealDetailViewModel() -> MealDetailViewModel {
        checkContainerCreated()
        let mealUseCase = container.createMealUseCase()
        return .init(mealUseCase: mealUseCase)
    }
}
