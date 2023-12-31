//
//  DIContainerImpl.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Domain
import Network
import Repositories
import Local

final class DIContainerImpl: DIContainer {
    
    private var api: Api = ApiImpl()
    private var imageCache: ImageCache = ImageCacheImpl()

    private func createMealRepository() -> MealRepository {
        let mealRepository = MealRepositoryImpl(api: self.api)
        return mealRepository
    }
    
    private func createImageRepository() -> ImageRepository {
        let imageRepository = ImageRepositoryImpl(api: self.api, imageCache: self.imageCache)
        return imageRepository
    }
    
    func createMealUseCase() -> MealUseCase {
        let mealRepository = createMealRepository()
        let imageRepository = createImageRepository()
        let useCase = MealUseCaseImpl(mealRepository: mealRepository, imageRepository: imageRepository)
        return useCase
    }
}
