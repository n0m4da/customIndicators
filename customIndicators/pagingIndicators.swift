//
//  pagingIndicators.swift
//  customIndicators
//
//  Created by Luis Rivera on 03/01/24.
//

import SwiftUI

struct pagingIndicators: View {
    //MARK: - properties
    var activeTint : Color = .primary
    var inActive : Color = .primary.opacity(0.15)
    var opacityEffect: Bool = false
    var clipEdges: Bool = false
    
    
    //MARK: - body
    var body: some View {
        GeometryReader{
            let width = $0.size.width
           
            if let scrollViewWidth = $0.bounds(of: .scrollView(axis: .horizontal))?.width, 
                scrollViewWidth > 0{
                    let totalPage = Int(width / scrollViewWidth)
                    let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                //MARK: - progress
                let freeProgress = -minX / scrollViewWidth
                let clippedProgress = min(max(freeProgress, 0.0), CGFloat(totalPage - 1))
                let progress = clipEdges ? clippedProgress : freeProgress
                let activeIndex = Int(progress)
                let nextIndex = Int(progress.rounded(.awayFromZero))
                let indicatorProgress = progress - CGFloat(activeIndex)
            
                let currentPageWith = 18 - (indicatorProgress * 18)
                let nextPaqgewIDTH = indicatorProgress * 18
                    HStack(spacing: 20){
                        ForEach(0..<totalPage, id:\.self){ index in
                            Circle()
                                .fill(inActive)
                                .frame(width: 8 + (activeIndex == index ? currentPageWith :  nextIndex == index ? nextPaqgewIDTH: 0), height: 8)
                                .overlay{
                                    ZStack{
                                        Capsule()
                                            .fill(inActive)
                                        
                                        Capsule()
                                            .fill(activeTint)
                                            .opacity(opacityEffect ? activeIndex == index ? 1 - indicatorProgress :  nextIndex == index ? nextPaqgewIDTH: 0 : 1)
                                    }
                                }
                        }
                    }
                    .frame(width: scrollViewWidth)

                    .offset(x: -minX)
            }
        }
        .frame(height: 30)
    }
}

#Preview {
    pagingIndicators()
}
