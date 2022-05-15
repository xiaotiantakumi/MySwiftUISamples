//
//  uiTextViewContainer.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/05/14.
//
//

import SwiftUI

protocol CursorPositionSettable { // use protocol to hide implementation
    func changeCursorPosition()
}
struct UITextViewContainer: UIViewRepresentable {
    @Binding var text : String
    @Binding var curPosition : Int

    func makeCoordinator() -> UITextViewContainer.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<UITextViewContainer>) -> UITextView {
        let inneruiTextView = UITextView(frame: .zero)
        inneruiTextView.font = UIFont.systemFont(ofSize: 22)
        inneruiTextView.text = text
        inneruiTextView.delegate = context.coordinator
        context.coordinator.setup(inneruiTextView)
        return inneruiTextView
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewContainer>) {
        uiView.text = self.text
        print("updateUIView")
    }
    func changeCursorPosition(direction:UITextLayoutDirection,offset:Int){
        //changeCursorPosition
    }
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: UITextViewContainer

        init(_ uiTextViewContainer: UITextViewContainer) {
            self.parent = uiTextViewContainer
        }
        var uiTextView:UITextView?
        func setup(_ textField:UITextView) {
            uiTextView = textField
            //textField.addTarget(self, action: #selector(textViewDidChange), for: .change)
        }

        func changeCursorPosition(_ uiTextView: UITextView,direction:UITextLayoutDirection,offset:Int){
            // only if there is a currently selected range
            if let selectedRange = uiTextView.selectedTextRange {
                // and only if the new position is valid
                if let newPosition = uiTextView.position(from: selectedRange.start, in:direction, offset: offset) {
                    // set the new position
                    uiTextView.selectedTextRange = uiTextView.textRange(from: newPosition, to: newPosition)
                }
            }
        }
        func changeCursorPosition2(direction:UITextLayoutDirection,offset:Int){
            // only if there is a currently selected range
            guard let uiTextView = uiTextView else {return}
            if let selectedRange = uiTextView.selectedTextRange {
                // and only if the new position is valid
                if let newPosition = uiTextView.position(from: selectedRange.start, in:direction, offset: offset) {
                    // set the new position
                    uiTextView.selectedTextRange = uiTextView.textRange(from: newPosition, to: newPosition)
                }
            }
        }
        @objc func textViewDidChange(_ uiTextView: UITextView) {
            self.parent.text = uiTextView.text ?? ""
        }


        @objc func textViewDidChangeSelection(_ uiTextView: UITextView) {
            guard let selectedTextRange = uiTextView.selectedTextRange else {
                return
            }
            // selectedTextRange.startはUITextPosition型なのでそこからIntにするにはこうする
            let cursorPosition = uiTextView.offset(from: uiTextView.beginningOfDocument, to: selectedTextRange.start)
            print(cursorPosition)
            self.parent.curPosition = cursorPosition
        }
    }
}
