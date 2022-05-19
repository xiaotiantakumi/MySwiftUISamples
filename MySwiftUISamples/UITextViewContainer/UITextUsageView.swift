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
    private var cursorChangeSubject = PassthroughSubject<CursorChangeableUIViewContext, Never>()

    var body: some View {
        VStack{
            UITextViewContainer(cursorChangeSubject: cursorChangeSubject,text: $text, cursorPosition: $cursorPosition)
                    .frame(height: 300)
                    .font(.title).border(.white, width: 1)
            HStack{
                Button(action:{
                    self.cursorChangeSubject.send(CursorChangeableUIViewContext(type:.changeCursorPosition,direction: .left, offset: 1))
                }){
                    Text("left").frame().background(.white).padding()
                }
                Button(action:{
                    self.cursorChangeSubject.send(CursorChangeableUIViewContext(type:.changeCursorPosition,direction: .right, offset: 1))
                }){
                    Text("right")
                }
            }
            Spacer()
        }
        Text(cursorPosition.description)
    }
}