//
//  SheetOpenSample.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/04/26.
//

import SwiftUI

struct ImageSliderUsage: View {
    var body: some View {
//        List {
//            ImageSlider()
//                    .frame(height: 300)
//                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//        }
        ImageSlider().frame(height: 300)
//                .frame(height: UIScreen.main.bounds.height - 100)
    }
}

struct ImageSlider: View {
    @State var preIndicatorTintColor = UIPageControl.appearance().currentPageIndicatorTintColor
    @State var prePageIndicatorTintColor = UIPageControl.appearance().pageIndicatorTintColor
    private let images = ["1.circle", "2.circle", "3.circle", "4.circle"]

    var body: some View {
        TabView {
            ForEach(Array(images.enumerated()), id: \.offset) { index, item in
                Image(systemName: item)
                        .resizable()
                        .scaledToFit()
                        .tabItem {
                            Image(systemName: "\(index + 1).circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                        }
            }
        }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .onAppear{
                    UIPageControl.appearance().currentPageIndicatorTintColor = .white
//                    UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
                }
                .onDisappear{
                    UIPageControl.appearance().currentPageIndicatorTintColor = preIndicatorTintColor
//                    UIPageControl.appearance().pageIndicatorTintColor = prePageIndicatorTintColor
                }
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        ImageSlider()
                .previewLayout(.fixed(width: 400, height: 300))
    }
}