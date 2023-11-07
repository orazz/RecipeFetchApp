//
//  AsyncImageView.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/3/23.
//

import SwiftUI

struct AppImageView: View {
    let image: Image?
    
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat = 10
    
    var body: some View {
        if let image = image {
            return AnyView(
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            )
        } else {
            return AnyView(
                Image("placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            )
        }
    }
}
