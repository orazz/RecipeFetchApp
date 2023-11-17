//
//  class MediaViewModel- ObservableObject {.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Combine
import Domain
import SwiftUI

class MealViewModel: ObservableObject {
    typealias BackgroundImage = (Image) -> Void
    
    @Published private(set) var viewState: ViewState = .loading
    @Published var mealList: [Meal] = []
    private let useCase: MealUseCase
    private var subscriptions = Set<AnyCancellable>()
    
    init(mealUseCase useCase: MealUseCase) {
        self.useCase = useCase
    }
    
    private func updateViewState(newState viewState: ViewState) {
        self.viewState = viewState
    }
    
    func fetchMealList() {
        guard mealList.isEmpty else { return }
        
        updateViewState(newState: .loading)
        
        useCase.fetchMealList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    let alertContent = AlertContent(message: error.localizedDescription)
                    self.updateViewState(newState: .error(alert: alertContent))
                case .finished: break
                }
            } receiveValue: { [weak self] mealList in
                self?.mealList = mealList
                self?.updateViewState(newState: .success)
            }
            .store(in: &subscriptions)
    }
    
    func fetchMealImage(withImageUrl imageUrl: String?, previewImage: @escaping BackgroundImage) {
        let placeholder = Image("placeholder")
        guard let imageUrl else {
            previewImage(placeholder)
            return
        }
        
        useCase.fetchImage(withImageUrl: imageUrl)
            .retry(3)
            .replaceError(with: placeholder)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { image in
                previewImage(image)
            })
            .store(in: &subscriptions)
    }
}
