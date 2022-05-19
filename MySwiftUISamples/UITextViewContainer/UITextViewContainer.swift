//
//  uiTextViewContainer.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/05/14.
//
//

import SwiftUI
import Combine


struct CursorChangeableUIViewContext{
    var type:UITextViewContainer.ApplyTypeEnum
    var direction:UITextLayoutDirection
    var offset:Int
}

class CursorChangeableUITextView: UITextView {
    func changeCursorPosition(direction:UITextLayoutDirection,offset:Int){
        // only if there is a currently selected range
        if let selectedRange = selectedTextRange {
            // and only if the new position is valid
            if let newPosition = position(from: selectedRange.start, in:direction, offset: offset) {
                // set the new position
                selectedTextRange = textRange(from: newPosition, to: newPosition)
            }
        }
    }
}

struct UITextViewContainer: UIViewRepresentable {
    var cursorChangeSubject: PassthroughSubject<CursorChangeableUIViewContext, Never>
    @State var cancellable: AnyCancellable? = nil
    @Binding var text : String
    @Binding var cursorPosition: Int
    enum ApplyTypeEnum {
        case changeCursorPosition
    }

    func makeCoordinator() -> UITextViewContainer.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<UITextViewContainer>) -> CursorChangeableUITextView {
        let inneruiTextView = CursorChangeableUITextView(frame: .zero)
        inneruiTextView.font = UIFont.systemFont(ofSize: 22)
        inneruiTextView.text = text
        inneruiTextView.delegate = context.coordinator
        context.coordinator.setup(inneruiTextView)

        // ここはメインスレッドで実行する必要があるようだ
        DispatchQueue.main.async {
            // very important to capture it as a variable, otherwise it'll be short lived.
            self.cancellable = cursorChangeSubject.sink { (value) in
                print("Received: \(value)")

                // こちらでどのメソッドが呼び出されたかをみて実施する
                if (value.type == ApplyTypeEnum.changeCursorPosition) {
                    inneruiTextView.changeCursorPosition(direction: value.direction, offset: value.offset)
                }
            }
        }

        return inneruiTextView
    }

    func updateUIView(_ uiView: CursorChangeableUITextView, context: UIViewRepresentableContext<UITextViewContainer>) {
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
        var uiTextView:CursorChangeableUITextView?
        func setup(_ textField:CursorChangeableUITextView) {
            uiTextView = textField
            //textField.addTarget(self, action: #selector(textViewDidChange), for: .change)
        }
        @objc func textViewDidChange(_ uiTextView: CursorChangeableUITextView) {
            self.parent.text = uiTextView.text ?? ""
        }
        @objc func textViewDidChangeSelection(_ uiTextView: CursorChangeableUITextView) {
            guard let selectedTextRange = uiTextView.selectedTextRange else {
                return
            }
            // selectedTextRange.startはUITextPosition型なのでそこからIntにするにはこうする
            let cursorPosition = uiTextView.offset(from: uiTextView.beginningOfDocument, to: selectedTextRange.start)
            //print(cursorPosition)
            self.parent.cursorPosition = cursorPosition
        }
    }
}
