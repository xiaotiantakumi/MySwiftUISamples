//
// Created by 小田匠 on 2022/05/04.
//

import Foundation

class MyXmlParser: NSObject, XMLParserDelegate , ObservableObject{
    func loadData(xmlString:String) {
        Task
        {
            let data = xmlString.data(using: .utf8)
            let parser: XMLParser? = XMLParser(data: data!)
            parser!.delegate = self
            parser!.parse()
        }
    }

    func parserDidStartDocument(_ parser: XMLParser) {
        print("Start")
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String: String]) {
        //XML中のタグの開始時に呼ばれる
        print("didStartElement")
        print(elementName)
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //タグ中のデータに対して呼ばれるメソッド
        print("foundCharacters")
        print(string)
    }

    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        //XML中のタグの終了時に対して呼ばれる
        print("didEndElement")
        print(elementName)
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        //XMLのパースの終了に呼ばれるメソッド
        print("parserDidEndDocument")
    }
}
