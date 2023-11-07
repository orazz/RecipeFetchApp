//
//  MealDetailViewModel.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/6/23.
//

import Foundation
import Combine
import Domain
import SwiftUI

class MealDetailViewModel: ObservableObject {
    typealias BackgroundImage = (Image) -> Void
    @Published private(set) var viewState: ViewState = .loading
    @Published var mealDetail: MealDetail!
    private let useCase: MealUseCase
    private var subscriptions = Set<AnyCancellable>()
    
    init(mealUseCase useCase: MealUseCase) {
        self.useCase = useCase
    }
    
    private func updateViewState(newState viewState: ViewState) {
        self.viewState = viewState
    }
    
    func fetchMealList(idMeal: String) {
        guard mealDetail == nil else { return }
        
        updateViewState(newState: .loading)
        
        useCase.fetchMealDetail(idMeal: idMeal)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    let alertContent = AlertContent(message: error.localizedDescription)
                    self.updateViewState(newState: .error(alert: alertContent))
                case .finished: break
                }
            } receiveValue: { [weak self] mealDetail in
                self?.mealDetail = mealDetail
                self?.updateViewState(newState: .success)
            }
            .store(in: &subscriptions)
    }
}
