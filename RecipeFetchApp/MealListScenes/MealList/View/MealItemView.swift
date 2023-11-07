//
//  MealItem.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/3/23.
//

import SwiftUI
import Domain

struct MealItemView: View {
    var item: Meal
    var width: CGFloat = .zero
    var height: CGFloat = .zero
    @ObservedObject private var viewModel: MealViewModel
    @State private var image: Image?
    
    init(item: Meal, width: CGFloat, height: CGFloat, viewModel: MealViewModel) {
        self.item = item
        self.width = width
        self.height = height
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            AppImageView(image: image, width: width, height: height).frame(width: width, height: height)
            
            Text(item.strMeal)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.label))
                .multilineTextAlignment(.center)
                .padding(.vertical, .defaultSpacing)
            Spacer()
        }
        .onAppear {
            fetchImageIfNeeded()
        }
    }
    
    private func fetchImageIfNeeded() {
        guard image == nil else { return }
        
        viewModel.fetchMealImage(withImageUrl: item.strMealThumb) { previewImage in
            image = previewImage
        }
    }
}
