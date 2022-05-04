//
//  SheetOpenSample.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/04/26.
//

import SwiftUI

struct SheetOpener: View {
    @State var isPresented = false
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.isPresented = true
            }) {
                ZStack{
                    Rectangle()
                            .frame(height: 80)
                            .cornerRadius(20)
                            .offset(x: 0, y: 20)
                            .foregroundColor(.gray)
                    Image(systemName: "chevron.up.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .offset(y: 5)
                }

            }
                    .sheet(isPresented: $isPresented) {
                        SheetOpenSample()
                    }
        }
    }
}

struct SheetOpenSample: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Hellow 1")
            Text("Hellow 2")
            Text("Hellow 3")
            Button("画面を閉じる") {
                dismiss()
            }
        }
    }
}

struct SheetOpenSample_Previews: PreviewProvider {
    static var previews: some View {
        SheetOpenSample()
    }
}
