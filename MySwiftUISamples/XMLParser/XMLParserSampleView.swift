//
//  XMLParserSampleView.swift
//  MySwiftUISamples
//
//  Created by 小田匠 on 2022/05/04.
//
//

import SwiftUI

struct XMLParserSampleView: View {
    var body: some View {
        Button(action: {
            let xml = """
                      <root>
                        <p>aiueo</p>
                        <p>kakikukeko</p>
                        <p>sasisuseso</p>
                      </root>
                      """
            MyXmlParser().loadData(xmlString: xml)
        }) {
            Text("Do XMLParse")
        }
    }
}

struct XMLParserSampleView_Previews: PreviewProvider {
    static var previews: some View {
        XMLParserSampleView()
    }
}
