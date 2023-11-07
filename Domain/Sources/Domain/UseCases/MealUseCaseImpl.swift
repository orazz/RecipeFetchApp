//
//  File.swift
//
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Combine
import SwiftUI

public class MealUseCaseImpl: MealUseCase {
    
    private var mealRepository: MealRepository
    private var imageRepository: ImageRepository
    
    public init(mealRepository: MealRepository, imageRepository: ImageRepository) {
        self.mealRepository = mealRepository
        self.imageRepository = imageRepository
    }
    
    public func fetchMealList() -> AnyPublisher<[Meal], DomainError> {
        Future { promise in
            Task {
                do {
                    let mealList = try await self.mealRepository.fetchMealList()
                    promise(.success(mealList))
                } catch {
                    promise(.failure(.cannotFetchMealList))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func fetchMealDetail(idMeal: String) -> AnyPublisher<MealDetail, DomainError> {
        Future { promise in
            Task {
                do {
                    let mealDetail = try await self.mealRepository.fetchMealDetail(idMeal: idMeal)
                    promise(.success(mealDetail))
                } catch {
                    promise(.failure(.cannotFetchMealDetail))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    public func fetchImage(withImageUrl imageUrl: String) -> AnyPublisher<Image, DomainError> {
        Future { promise in
            Task {
                var uiImage: UIImage
                do {
                    uiImage = try await self.imageRepository.fetchImageFromLocal(imageUrl: imageUrl)
                } catch {
                    guard let imageFromServer = try? await self.imageRepository.fetchImageFromServer(imageUrl: imageUrl) else {
                        throw DomainError.cannotLoadImage
                    }
                    uiImage = imageFromServer
                    try? await self.imageRepository.saveImageToDisk(imageUrl: imageUrl, image: uiImage)
                }
                let image = Image(uiImage: uiImage)
                promise(.success(image))
            }
        }
        .eraseToAnyPublisher()
    }

}
