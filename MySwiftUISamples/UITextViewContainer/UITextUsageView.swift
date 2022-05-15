//
//  TextFieldUsageView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/05/15.
//
//

import SwiftUI
import Combine

struct UITextUsageView: View {
    @State var text = ""
    @State var cursorPosition = 0
    private var didChange = PassthroughSubject<CursorChangeableUIViewContext, Never>()

    var body: some View {
        VStack{
            UITextViewContainer(didChange: didChange,text: $text, curPosition: $cursorPosition)
                    .frame(height: 300)
                    .font(.title).border(.white, width: 1)
            Spacer()
            Button(action:{
                self.didChange.send(CursorChangeableUIViewContext(type:.changeCursorPosition,direction: .left, offset: 1))
            }){
                Text("left")
            }
        }
        Text(cursorPosition.description)

    }
}