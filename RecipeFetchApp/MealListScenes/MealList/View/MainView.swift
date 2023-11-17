//
//  MainView.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/3/23.
//

import SwiftUI
import Domain

struct MainView: View {
    @StateObject private var viewModel = ViewModelFactory.shared.createMealViewModel()
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2 * .padding, alignment: .center), count: 2)
    
    var body: some View {
        NavigationView {
            ZStack {
                switch viewModel.viewState {
                case .loading: ProgressView()
                case .success:
                    GeometryReader { geometry in
                        let size = geometry.size.width/2 - 2 * .padding
                        ScrollView {
                            LazyVGrid(columns: columns,
                                      spacing: .padding) {
                                ForEach($viewModel.mealList) { meal in
                                    NavigationLink {
                                        MealDetailView(meal: meal.wrappedValue)
                                    } label: {
                                        MealItemView(item: meal.wrappedValue, width: size, height: size, viewModel: viewModel)
                                            .frame(height: geometry.size.width/2 + .labelHeight)
                                    }
                                }
                            }
                            .padding(.padding)
                        }
                    }
                case .error(let alert):
                    CustomAlertView(alertContent: alert) {
                        viewModel.fetchMealList()
                    }
                }
            }
            .navigationBarTitle(Text("Dessert"), displayMode: .inline)
            .onAppear {
                viewModel.fetchMealList()
            }
        }
    }
}

#Preview {
    MainView()
}
