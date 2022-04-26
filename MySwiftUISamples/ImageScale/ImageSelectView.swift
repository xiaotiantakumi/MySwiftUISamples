//
//  ImageFromAssetsView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

struct ImageSelectView: View {
    @State var imageFromAsset: UIImage? = nil
    @State var firstImageState:imageSelectState = .normal
    @State var secoundImageState:imageSelectState = .normal
    var body: some View {
        Button(action: {
        }) {
            ZStack {
                Image("icons8-swiftui-240")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                SelectStateView(imageMode: $firstImageState)
            }
        }
                .frame(width: 200, height: 200)
        Button(action: {
        }) {
            ZStack {
                Image("icons8-swiftui-240")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                SelectStateView(imageMode: $secoundImageState)
            }
        }
                .frame(width: 200, height: 200)
        Button(action: {
            if(firstImageState == .normal){
                firstImageState = .unselect
                secoundImageState = .selected
            }else{
                firstImageState = .normal
                secoundImageState = .normal
            }
        }) {
            Text("切替")
        }
    }
}

struct SelectStateView: View {
    @Binding var imageMode: imageSelectState
    var body: some View {
        if (imageMode == .normal) {
            EmptyView()
        } else if (imageMode == .unselect) {
            VStack {
                Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 30, height: 30)
                        .offset(y: 50)
            }
        } else if (imageMode == .selected) {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(y: 50)
            }
        }
    }
}
enum imageSelectState {
    case normal
    case unselect
    case selected
}
struct ImageSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromAssetsView()
    }
}
