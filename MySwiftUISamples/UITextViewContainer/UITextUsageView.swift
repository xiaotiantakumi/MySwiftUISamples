//
//  TextFieldUsageView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/05/15.
//
//

import SwiftUI

struct UITextUsageView: View {
    @State var text = ""
    @State var cursorPosition = 0
    private var uiTextViewContainer: UITextViewContainer {
        UITextViewContainer(text: $text, curPosition: $cursorPosition)
    }
    var body: some View {
        VStack{
            uiTextViewContainer.frame(height: 300).font(.title).border(.white, width: 1)
            Spacer()
        }
        Text(cursorPosition.description)

    }
}