//
//  CustomAlertView.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/4/23.
//

import SwiftUI

struct CustomAlertView: View {
    typealias TryAgainAction = () -> Void
    
    private var alertContent: AlertContent
    private var tryAgainAction: TryAgainAction

    init(alertContent: AlertContent, tryAgainAction: @escaping TryAgainAction) {
        self.alertContent = alertContent
        self.tryAgainAction = tryAgainAction
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                VStack(spacing: 32) {
                    Text(alertContent.message ?? "Error")
                    Button {
                        tryAgainAction()
                    } label: {
                        Text("Try again")
                    }
                }
                .frame(width: geometry.size.width - 80)
                .cornerRadius(12)
                .transition(.scale)
            }
        }
    }
}
