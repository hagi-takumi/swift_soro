//
//  MemoDataModel.swift
//  MyColorMemo_1
//
//  Created by Takumi_Hagi_BTC4 on 2023/06/12.
//

import Foundation
import RealmSwift

//メモのデータ構造を指定してHOMEで使用する
//struct MemoDataModel{
////    メモに必要なプロパティ
//    var text:String
//    var recordDate:Date
//}

class MemoDataModel:Object{
    //データの一意に識別するための識別子（参照するたびに一意の文字列を返す）
    //データを保存する際に識別するため
    @objc dynamic var id:String=UUID().uuidString
    //    メモに必要なプロパティ
    @objc dynamic var text:String=""
    @objc dynamic var recordDate:Date=Date()

}
