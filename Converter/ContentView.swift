//
//  ContentView.swift
//  Converter
//
//  Created by Florian on 01/04/2022.
//

import SwiftUI

enum DataType: String, CaseIterable {
    case celcius
    case fahrenheit
    case kalvin
}

struct ContentView: View {
    @State private var inputValue: Double = 0.0
    @State private var inputType: DataType = .celcius
    @State private var outputType: DataType = .fahrenheit

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("", selection: $inputType) {
                        ForEach(DataType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Enter amount", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("input")
                }

                Section {
                    Picker("", selection: $outputType) {
                        ForEach(DataType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)

                    Text(convertValue(value: inputValue, input: inputType, output: outputType), format: .number)
                } header: {
                    Text("output")
                }
            }
            .navigationTitle("Degree converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {

    private func convertValue(value: Double, input: DataType, output: DataType) -> Double {
        switch (input, output) {
        case (.celcius, .fahrenheit): return value * 1.8 + 32
        case (.celcius, .kalvin): return value + 273.15

        case (.fahrenheit, .celcius): return (value - 32) / 1.8
        case (.fahrenheit, .kalvin): return (value  + 459.67) * 5 / 9

        case (.kalvin, .celcius): return value - 273.15
        case (.kalvin, .fahrenheit): return value * 9 / 5 - 459.67

        default: return value
        }
    }

}
