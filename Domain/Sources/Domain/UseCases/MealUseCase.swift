//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Combine
import SwiftUI

public protocol MealUseCase {
    func fetchMealList() -> AnyPublisher<[Meal], DomainError>
    func fetchMealDetail(idMeal: String) -> AnyPublisher<MealDetail, DomainError>
    func fetchImage(withImageUrl imageUrl: String) -> AnyPublisher<Image, DomainError>
}
