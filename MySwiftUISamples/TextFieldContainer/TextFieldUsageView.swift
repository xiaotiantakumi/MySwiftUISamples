//
//  TextFieldUsageView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/05/15.
//
//

import SwiftUI

struct TextFieldUsageView: View {
    @State var text = ""
    @State var cursorPosition = 0
    private var textField: TextFieldContainer {
        TextFieldContainer("", text: $text, curPosition: $cursorPosition)
//                .frame(height: 100).border(.white, width: 1)
    }
    var body: some View {
        textField.frame(height: 100).border(.white, width: 1)
        Text(cursorPosition.description)
//        Button(action:{
//            textField.
//        })
//        { Text("left")
//        }
    }
}

struct TextFieldUsageView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldUsageView()
    }
}
