//
//  ImageFromAssetsView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

struct ImageFromAssetsView: View {
    @State var imageFromAsset:UIImage? = nil
    var body: some View {
        if let uiImage = imageFromAsset{
            // UIImageで設定
            VStack{
                Text("UIImage生成パターン")
                Image(uiImage: uiImage)
            }
        }
        // pathで直接SwifUIのImage指定
        VStack{
            Text("ImageViewで直接生成")
            Image("icons8-swiftui-240")
        }
        .onAppear{
            imageFromAsset = UIImage(named:"icons8-swiftui-240")
        }
    }
}

struct ImageFromAssetsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromAssetsView()
    }
}
