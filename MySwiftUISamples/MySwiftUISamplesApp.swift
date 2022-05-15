//
//  MySwiftUISamplesApp.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

@main
struct MySwiftUISamplesApp: App {
    @State var selectedIndex = -1
    @State var selectedIndex2 = -1
    var body: some Scene {
        WindowGroup {
            TextFieldUsageView()
        }
    }
}
