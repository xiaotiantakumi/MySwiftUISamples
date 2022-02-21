//
//  ImageFromAssetsView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/02/14.
//

import SwiftUI

struct SimpleLongPressGestureView: View {
    @GestureState var isDetectingLongPress = false

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1)
                .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                    gestureState = currentState
                }
    }

    var body: some View {
        Circle()
                .fill(self.isDetectingLongPress ? Color.red : Color.green)
                .frame(width: 100, height: 100, alignment: .center)
                .gesture(longPress)
    }
}

struct MagnificationGestureView: View {

    @GestureState var magnifyBy = 1.0

    var magnification: some Gesture {
        MagnificationGesture()
                .updating($magnifyBy) { currentState, gestureState, transaction in
                    gestureState = currentState
                }
    }

    var body: some View {
        Circle()
                .frame(width: 100, height: 100)
                .scaleEffect(magnifyBy)
                .gesture(magnification)
    }
}