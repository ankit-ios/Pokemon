//
//  RangeSliderView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import SwiftUI

struct RangeSliderView: View {
    @State private var minValue: Double = 25.0
    @State private var maxValue: Double = 75.0
    let range: ClosedRange<Double> = 0...100

    var body: some View {
        HStack {
            Text("Range: \(Int(minValue)) - \(Int(maxValue))")
            
            HStack {
                Text("\(Int(range.lowerBound))")
                Slider(value: $minValue, in: range)
                Text("\(Int(range.upperBound))")
            }
            
            HStack {
                Text("Min: \(Int(minValue))")
                Text("Max: \(Int(maxValue))")
            }
        }
    }
}
