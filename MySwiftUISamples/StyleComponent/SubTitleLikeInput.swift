//
//  SubTitleLikeInput.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/04/26.
//

import SwiftUI

struct SubTitleLikeInput: View {
    @Binding var inValue : String
    let font:Font = .title
    var body: some View {
        HStack{
            Title(
                title:"Sample",font: font)
            TextField("",text: $inValue).font(font).background(.gray).cornerRadius(5)
            Spacer(minLength: 15)
        }
    }
}

struct Title: View {
    let title : String
    let font : Font?
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 5).frame(width: 6, height: 20).foregroundColor(.blue).offset(x: 5, y: 0)
            Text(title).font(font)
        }
    }
}

struct GeometText:View{
    @State var font : Font?
    var body: some View{
        GeometryReader{ geometry in
            Text("Title").font(font).frame(width: geometry.size.width,
                    height: geometry.size.height/2,
                    alignment: .center)
        }
    }
}

struct SubTitleLikeInput_Previews: PreviewProvider {
    @State static var inValue = ""
    static var  font = Font.title
    static var previews: some View {
        SubTitleLikeInput(inValue: $inValue)
    }
}
