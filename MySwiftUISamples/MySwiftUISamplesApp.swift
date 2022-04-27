//
//  MySwiftUISamplesApp.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

@main
struct MySwiftUISamplesApp: App {
    @State var text = ""
    @State var selectedIndex = -1
    @State var selectedIndex2 = -1
    var body: some Scene {
        WindowGroup {
            //SubTitleLikeInput(inValue: $text)
            RadioButtons(marginX: 30,marginY: 0,selectedIndex: $selectedIndex)
            RadioButtons(cornerRadius: 10,recWidth: 50,recHeight: 50,marginX: 12,marginY: 12,selectedIndex: $selectedIndex2)
        }
    }
}
