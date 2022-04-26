//
//  ContentView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("サンプル")) {
                    NavigationLink(destination: ImageSelectView()) {
                        Text("ImageSelectView")
                    }
                    NavigationLink(destination: ImageScaleView()) {
                        Text("ImageScaleView")
                    }
                    NavigationLink(destination: ImageScaleView2()) {
                        Text("ImageScaleView2")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
