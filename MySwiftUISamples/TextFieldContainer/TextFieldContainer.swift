//
//  TextFieldContainer.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/05/14.
//
//

import SwiftUI

struct TextFieldContainer: UIViewRepresentable {
    private var placeholder : String
    private var text : Binding<String>
    private var curPosition : Binding<Int>

    init(_ placeholder:String, text:Binding<String>, curPosition:Binding<Int>) {
        self.placeholder = placeholder
        self.text = text
        self.curPosition = curPosition
    }

    func makeCoordinator() -> TextFieldContainer.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<TextFieldContainer>) -> UITextField {
        let innerTextField = UITextField(frame: .zero)
        innerTextField.placeholder = placeholder
        innerTextField.text = text.wrappedValue
        innerTextField.delegate = context.coordinator
        context.coordinator.setup(innerTextField)

        return innerTextField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldContainer>) {
        uiView.text = self.text.wrappedValue
        print("updateUIView")
    }
    func changeCursorPosition(direction:UITextLayoutDirection,offset:Int){

    }
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldContainer

        init(_ textFieldContainer: TextFieldContainer) {
            self.parent = textFieldContainer
        }

        func setup(_ textField:UITextField) {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }

        func changeCursorPosition(_ textField: UITextField,direction:UITextLayoutDirection,offset:Int){
            // only if there is a currently selected range
            if let selectedRange = textField.selectedTextRange {
                // and only if the new position is valid
                if let newPosition = textField.position(from: selectedRange.start, in:direction, offset: offset) {
                    // set the new position
                    textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
                }
            }
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            self.parent.text.wrappedValue = textField.text ?? ""
        }


        @objc func textFieldDidChangeSelection(_ textField: UITextField) {
            guard let selectedTextRange = textField.selectedTextRange else {
                return
            }
            // selectedTextRange.startはUITextPosition型なのでそこからIntにするにはこうする
            let cursorPosition = textField.offset(from: textField.beginningOfDocument, to: selectedTextRange.start)
            print(cursorPosition)
            self.parent.curPosition.wrappedValue = cursorPosition
        }
    }
}
