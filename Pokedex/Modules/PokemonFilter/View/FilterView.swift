//
//  FilterView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: FilterViewModel
    @Binding var isFilterSheetPresented: Bool
    
    init(isFilterSheetPresented: Binding<Bool>, filterModel: Binding<FilterModel>) {
        self._isFilterSheetPresented = isFilterSheetPresented
        self._vm = StateObject(wrappedValue: .init(filterModel: filterModel))
    }
    
    var body: some View {
        VStack {
            Spacer()
            NavigationHeaderView(model: NavigationHeaderItem(title: AppScreenTitles.filter, subTitle: "", isPresented: presentationMode, close: {
                isFilterSheetPresented = false
            })).padding(.horizontal)
            
            ScrollView {
                AccordionView(model: vm.getTypeData(), isExpanded: $vm.isTypeExpanded, checkedItems: $vm.typeCheckedItems)
                AccordionView(model: vm.getGenderData(), isExpanded: $vm.isGenderExpanded, checkedItems: $vm.genderCheckedItems)
                Spacer()
            }
            .padding()
            
            HStack {
                Button(FilterScreenLabels.resetButton) {
                    vm.resetButtonTapped()
                    isFilterSheetPresented = false
                }
                .buttonStyle(SecondaryButtonStyle())
                
                Spacer()
                Button(FilterScreenLabels.applyButton) {
                    vm.applyButtonTapped()
                    isFilterSheetPresented = false
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(.horizontal, 40)
            .padding(.top, 10)
            .background(AppColors.Background.primary)
            .background(
                Rectangle()
                    .fill(.white)
                    .shadow(color: AppColors.Text.primary.opacity(0.3), radius: 4, x: 0, y: -4)
            )
            Spacer()
        }
        .background(AppColors.Background.primary)
        
        // Firebase tracing
        .onAppear {
            vm.updateUIWithSelectedFilter()
        }
        .cornerRadius(8)
        .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height * 0.8)
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(isFilterSheetPresented: .constant(false), filterModel: .constant(.init()))
    }
}
