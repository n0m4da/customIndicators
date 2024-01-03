//
//  ContentView.swift
//  customIndicators
//
//  Created by Luis Rivera on 03/01/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    @State private var colors: [Color] = [.red, .blue, .green, .yellow]
    @State private var opacityEffect : Bool = false
    @State private var clipEdges : Bool = false
    //MARK: - BODY
    var body: some View {
        VStack {
            ScrollView(.horizontal){
                LazyHStack(spacing: 0) {
                    ForEach(colors, id:\.self){ color in RoundedRectangle(cornerRadius: 25)
                            .fill(color.gradient)
                            .padding(.horizontal, 15)
                            .containerRelativeFrame(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                    }
                }
                .scrollTargetLayout()
                .overlay(alignment: .bottom){
                    pagingIndicators(activeTint: .white, inActive: .black.opacity(0.25), opacityEffect: opacityEffect,clipEdges: clipEdges)
                }
         
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .frame(height: 220)
            .safeAreaPadding(.vertical, 15)
            .safeAreaPadding(.horizontal, 25)
            
            List{
                Section("Options"){
                    Toggle("Opaity Effect", isOn: $opacityEffect)
                    Toggle("Clip Edges", isOn: $clipEdges)
                    
                    Button("Add item"){
                        colors.append(.purple)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 15))
            .padding(15)
        }
        .navigationTitle("Custom Indicators")
    }
}

#Preview {
    ContentView()
}
