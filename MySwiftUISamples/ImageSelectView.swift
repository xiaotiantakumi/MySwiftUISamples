//
//  ImageFromAssetsView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

struct ImageSelectView: View {
    @State var imageFromAsset: UIImage? = nil
    var body: some View {
        Button(action: {
            print("tapped")
        }) {
            ZStack {
                Image("icons8-swiftui-240")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                VStack {
                    Circle()
                            .stroke(lineWidth: 2)
                            .frame(width: 30, height: 30)
                            .offset(y: 50)
                }
            }
        }
                .frame(width: 200, height: 200)
        Button(action: {
            print("tapped")
        }) {
            ZStack {
                Image("icons8-swiftui-240")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .offset(y: 50)
                }
            }
        }
                .frame(width: 200, height: 200)
    }
}

struct ImageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromAssetsView()
    }
}
