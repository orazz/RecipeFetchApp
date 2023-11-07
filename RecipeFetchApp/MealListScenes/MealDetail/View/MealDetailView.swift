//
//  MealDetailView.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/5/23.
//

import SwiftUI
import Domain

struct MealDetailView: View {
    
    @StateObject private var viewModel = ViewModelFactory.shared.createMealDetailViewModel()
    private let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading: ProgressView()
            case .success:
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: .padding) {
                        Text(viewModel.mealDetail.strMeal)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(UIColor.label))
                        Text(viewModel.mealDetail.strInstructions)
                            .foregroundColor(Color(UIColor.label))
                        Text("Ingredients")
                            .font(.headline)
                            .fontWeight(.bold)
                        ForEach(viewModel.mealDetail.ingredientsAndMeasures, id: \.self) { instruction in
                            Text(instruction)
                        }
                        Spacer()
                    }
                    .padding(.padding)
                }
            case .error(let alert):
                CustomAlertView(alertContent: alert) {
                    viewModel.fetchMealList(idMeal: meal.idMeal)
                }
            }
        }
        .onAppear {
            viewModel.fetchMealList(idMeal: meal.idMeal)
        }
    }
}
