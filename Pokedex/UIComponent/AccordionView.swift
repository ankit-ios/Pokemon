//
//  AccordionView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 23/10/23.
//

import SwiftUI

struct AccordianModel: Identifiable {
    let id = UUID()
    let title: String
    let items: [String]
    var checkedItems: [String: Bool] = [:]
}

struct AccordionView: View {
    
    var model: AccordianModel
    @Binding var isExpanded: Bool
    @Binding var checkedItems: [String: Bool]
    
    var body: some View {
        ZStack {
            VStack {
                DisclosureGroup(isExpanded: $isExpanded.animation(), content: {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))], alignment: .leading, spacing: 20, content: {
                        ForEach(model.items, id: \.self) { item in
                            CheckboxView(text: item.capitalized, isChecked: binding(for: item))
                        }
                    })
                }, label: {
                    HStack {
                        Text(model.title)
                            .font(AppFont.subtitle)
                            .foregroundColor(AppColors.Text.primary)
                            .frame(width: 100)
                        
                        Divider()
                            .background(AppColors.Text.primary)
                            .frame(width: 2)
                        
                        Text(getTitleDetail().capitalized)
                            .font(AppFont.caption)
                            .foregroundColor(AppColors.Text.primary)
                            .padding(.leading, 10)
                    }
                })
                .disclosureGroupStyle(CustomDisclosureGroupStyle(image: isExpanded ? AppImages.collapse : AppImages.expand))
                .padding()
            }
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppColors.Text.primary, lineWidth: 2)
        }
        .padding(.all, 2)
    }
    
    private func binding(for item: String) -> Binding<Bool> {
        Binding(
            get: { self.checkedItems[item] ?? false },
            set: { self.checkedItems[item] = $0 }
        )
    }
    
    private func getTitleDetail() -> String {
        let checkedCount = checkedItems.values.filter { $0 }.count
        guard checkedCount > 0 else { return "" }
        
        let firstSelectedItem = checkedItems.first { $0.value }?.key ?? ""
        return checkedCount == 1 ? "\(firstSelectedItem)" : "(\(firstSelectedItem) + \(checkedCount - 1) More)"
    }
}
