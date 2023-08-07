//
//  MaskB.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Baris Karalar on 12.07.23.
//

import SwiftUI

struct MaskB: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        
        ZStack {
            starsView
                .overlay {overlayView.mask(starsView)}
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index                            
                        }
                    }
            }
        }
    }
    
}

struct MaskB_Previews: PreviewProvider {
    static var previews: some View {
        MaskB()
    }
}
