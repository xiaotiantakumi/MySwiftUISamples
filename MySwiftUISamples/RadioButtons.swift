//
//  RadioButton.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/04/27.
//

import SwiftUI

struct RadioButtons: View {
    /**
     ラジオボタンを角丸にしたい場合はここの数値を変更する
     */
    @State var cornerRadius:CGFloat = 5
    /**
     ラジオボタンの横幅
     */
    @State var  recWidth:CGFloat = 30
    /**
     ラジオボタンの高さ
     */
    @State var  recHeight:CGFloat = 30
    /**
     ボタン横の間隔
     */
    @State var  marginX:CGFloat = 5
    /**
     ボタン縦の間隔
     */
    @State var  marginY:CGFloat = 5
    /**
     選択時の色
     */
    @State var  selectedColor:Color = .orange
    /**
     非選択時の色
     */
    @State var  unSelectedColor:Color = .gray
    /**
     ラジオボタンとして列挙する要素
     */
    @State var  items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    /**
     ここで指定した数を超えた時に改行する
     */
    @State var  breakAt = 5
    /**
     要素数とbreakAtから行数を計算
     */
    var rows : Int {
        get {
            let ceilVal = (items.count + (breakAt - 1)) / breakAt
            return ceilVal
        }
    }
    /**
     選択されている要素のIndex
     */
    @Binding var selectedIndex:Int
    var body: some View {
        VStack(spacing: marginY){
            ForEach(0 ..< rows){ rowNum in
                let start = rowNum * breakAt
                let end = (rowNum + 1) * breakAt
                let rowItems = items[start ..< end]
                HStack(spacing: marginX) {
                    ForEach(rowItems, id: \.self) { item in
                        Button(action: {
                            let index = items.firstIndex(of: item)
                            self.selectedIndex = index!
                            print(self.selectedIndex)
                        }) {
                            ZStack{
                                let index = items.firstIndex(of: item)
                                let color:Color = index == self.selectedIndex ? selectedColor : unSelectedColor
                                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(color).frame(width: recWidth, height: recHeight).opacity(0.5)
                                Text(item).foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    @State static var selectedIndex = -1
    static var previews: some View {
        RadioButtons(selectedIndex: $selectedIndex)
    }
}
