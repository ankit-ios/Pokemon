//
//  NavigationHeaderView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct NavigationHeaderItem {
    let title: String
    let subTitle: String
    @Binding var isPresented: PresentationMode
    var close: (() -> Void)?
}

struct NavigationHeaderView: View {
    
    let model: NavigationHeaderItem
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(model.title)
                if !model.subTitle.isEmpty {
                    Text(model.subTitle)
                }
            }
            .font(AppFont.navigationTitle)
            .foregroundColor(AppColors.Text.primary)
            
            Spacer()
            Button(action: {
                model.$isPresented.wrappedValue.dismiss()
                model.close?()
            }) {
                AppImages.close
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(AppColors.Text.primary)
            }
        }
    }
}
