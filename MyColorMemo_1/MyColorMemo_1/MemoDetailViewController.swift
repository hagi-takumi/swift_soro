//
//  MemoDetailViewController.swift
//  MyColorMemo_1
//
//  Created by Takumi_Hagi_BTC4 on 2023/06/13.
//

import UIKit
import RealmSwift

class MemoDetailViewController:UIViewController{
    @IBOutlet weak var textView: UITextView!
//    var text:String=""
//    var recordDate:Date=Date()
    var memoData=MemoDataModel()

    var dateFormat:DateFormatter{
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat="yyyy年MM月dd日"
        return dateFormatter
    }

    //    オーバーライドで既存のviewDidLoadにdisplayDataを追加
    //このクラスの画面が表示される際に呼び出されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        setDoneButton()
        textView.delegate=self



        self.textView.becomeFirstResponder()
    }
    //    MemoDataModel.swiftより
    func configure(memo:MemoDataModel){
//        追加
        memoData=memo
//        終了
//        memoData.text=memo.text
//        memoData.recordDate=memo.recordDate
//        print("データは\(memoData.text) と\(memoData.recordDate)")
    }

    //    表示内容を代入
    func displayData(){
        textView.text=memoData.text
        navigationItem.title=dateFormat.string(from: memoData.recordDate)
    }

    @objc func tapDoneButton(){
        view.endEditing(true)
    }

    func setDoneButton(){
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:40))
        let commitButton=UIBarButtonItem(barButtonSystemItem: .done, target:self, action: #selector(tapDoneButton))
        toolBar.items=[commitButton]
        textView.inputAccessoryView=toolBar
    }

    func saveData(with text:String){
        let realm = try! Realm()
        try! realm.write{
            memoData.text=text
            memoData.recordDate=Date()
//            取り敢えず追加しない_変更
//            realm.add(memoData)
        }
        print("text:\(memoData.text),recordDate:\(memoData.recordDate)")
    }


}

extension MemoDetailViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let updatedText = textView.text ?? ""
        saveData(with: updatedText)
    }
}
