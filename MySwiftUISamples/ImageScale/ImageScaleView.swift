//
//  ImageFromAssetsView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

struct ImageScaleView: View {
    @State var imageFromAsset: UIImage? = nil
    @State var lastValue: CGFloat = 1.0
    @State var scale: CGFloat = 1.0
    @State var anchor: UnitPoint = .center
    var body: some View {
        GeometryReader { imageView in
            Image("icons8-swiftui-240")
                    .scaleEffect(self.scale, anchor: anchor)
                    .gesture(MagnificationGesture()
                            .onChanged { value in
                                // 前回の値から拡大率を計算する
                                let delta = value / self.lastValue
                                // 現在の拡大率を再設定する
                                self.scale = self.scale * delta
                                // 現在の拡大率を覚えておく
                                self.lastValue = value
                            }
                            .onEnded { value in
                                // 次のジェスチャーイベントではvalueはまた1.0から始まるため
                                // ジェスチャーイベント完了時に1.0に戻しておく
                                self.lastValue = 1.0
                            }
                    )
                    .onTapGesture(count: 2) {
                        if (self.scale > 1) {
                            self.scale = 1.0
                        } else {
                            self.scale = 3.0
                        }
                    }
        }
    }
}

struct ImageScaleView2: View {

    let maxScale: CGFloat = 5.0
    let minScale: CGFloat = 1.0

    @State var lastValue: CGFloat = 1.0
    @State var scale: CGFloat = 1.0
    @State var draged: CGSize = .zero
    @State var prevDraged: CGSize = .zero
    @State var tapPoint: CGPoint = .zero
    @State var isTapped: Bool = false

    var body: some View {
        // MagnificationGestureは拡大動作(二本指で拡大する動作)を認識し、拡大量を追跡するジェスチャーです。
        let magnify = MagnificationGesture(minimumScaleDelta: 0.2)
                // タップ中の変化を刻々とイベントとして補足する。拡大量を閾値としてminimumScaleDeltaで設定する。
                .onChanged { value in
                    // 拡大量を計算
                    let resolvedDelta = value / self.lastValue
                    self.lastValue = value
                    let newScale = self.scale * resolvedDelta
                    // 最大値と最小値の範囲に収まるようにする
                    self.scale = min(self.maxScale, max(self.minScale, newScale))
                    print("delta=\(value) resolvedDelta=\(resolvedDelta)  newScale=\(newScale)")
                }
        // 拡大の起点位置を変更する時に使用する。
        let gestureDrag = DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { (value) in
                    self.tapPoint = value.startLocation
                    self.draged = CGSize(width: value.translation.width + self.prevDraged.width,
                            height: value.translation.height + self.prevDraged.height)
                }
        return GeometryReader { geo in
            Image("icons8-swiftui-240")
                    .resizable().scaledToFit().animation(.default)
                    .offset(self.draged)
                    .scaleEffect(self.scale)
                    .gesture(
                            TapGesture(count: 2).onEnded({
                                        // ここはダブルタップ時に呼ばれる
                                        print("TapGesture onEnded")
                                        self.isTapped.toggle()
                                        // 拡大縮小をタップで切り替える
                                        if self.scale > 1 {
                                            self.scale = 1
                                        } else {
                                            self.scale = 2
                                        }
                                        let parent = geo.frame(in: .local)
                                        self.postArranging(translation: CGSize.zero, in: parent)
                                    })
                                    // ジェスチャーと別のジェスチャーを組み合わせて新しいジェスチャーを作成し、両方のジェスチャーを同時に認識させる。
                                    // 画像をタップしたタイミングで呼ばれる
                                    .simultaneously(with: gestureDrag.onEnded({ (value) in
                                        print("simultaneously gesture")
                                        let parent = geo.frame(in: .local)
                                        self.postArranging(translation: value.translation, in: parent)
                                    })
                                    ))
                    .gesture(magnify.onEnded { value in
                        // without this the next gesture will be broken
                        self.lastValue = 1.0
                        let parent = geo.frame(in: .local)
                        self.postArranging(translation: CGSize.zero, in: parent)
                    })
        }
    }

    /// 画像のドラッグでどこか別のところに行ってしまう問題を解決している？
    private func postArranging(translation: CGSize, in parent: CGRect) {
        let scaled = self.scale
        let parentWidth = parent.maxX
        let parentHeight = parent.maxY
        let offset = CGSize(width: (parentWidth * scaled - parentWidth) / 2,
                height: (parentHeight * scaled - parentHeight) / 2)

        print("offset\(offset)")
        var resolved = CGSize()
        let newDraged = CGSize(width: self.draged.width * scaled,
                height: self.draged.height * scaled)
        if newDraged.width > offset.width {
            resolved.width = offset.width / scaled
        } else if newDraged.width < -offset.width {
            resolved.width = -offset.width / scaled
        } else {
            resolved.width = translation.width + self.prevDraged.width
        }
        if newDraged.height > offset.height {
            resolved.height = offset.height / scaled
        } else if newDraged.height < -offset.height {
            resolved.height = -offset.height / scaled
        } else {
            resolved.height = translation.height + self.prevDraged.height
        }
        self.draged = resolved
        self.prevDraged = resolved
    }
}