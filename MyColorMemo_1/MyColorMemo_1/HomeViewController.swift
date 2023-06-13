//
//  HomeViewController.swift
//  MyColorMemo_1
//
//  Created by Takumi_Hagi_BTC4 on 2023/06/12.
//

import Foundation
//UIに関するクラスが格納されたモジュール(UIViewControllerを使用するために)
import UIKit
import RealmSwift
//HomeViewControllerにUIViewControllerを「クラス継承」してメソッドを使用できるようにしている
class HomeViewController:UIViewController{
    
    @IBOutlet weak var tableView: UITableView!

    //    メモ内容を格納する配列を準備
    //    MemoDataModelは、メモデータを表現するためのデータモデル（MemoDataModel.swiftより）
    var memoDataList:[MemoDataModel]=[]
    let themeColorTypeKey="themColorTypeKey"

    override func viewDidLoad() {
        //このクラスの画面が表示される際に呼び出されるメソッド(一回だけ)
        //画面の表示・非表示に応じて実行されるメソッドを「ライフサイクルメソッド」と呼ぶ
        print("HomeViewControllerが表示")
        tableView.dataSource=self
        //        UITableViewDelegateを連携させるため
        tableView.delegate=self

        //        空白のフッダーを表示させて指定数分だけリストを表示するようにする
        tableView.tableFooterView=UIView()
        setMemoData()
        setNavigationBarButton()
        setLeftNavigationBarButton()
        let themeColorTypeInt=UserDefaults.standard.integer(forKey: themeColorTypeKey)
        let themeColorType=MyColorType(rawValue: themeColorTypeInt) ?? .default


        setThemeColor(type: themeColorType)
    }

    //    画面が表示される直前に起動（ライフサイクル_毎回）
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        データの更新
        setMemoData()
        //        テーブルを更新
        tableView.reloadData()
    }

    //    メモの内容を格納するメソッド
    func setMemoData(){
        //        インスタンス化
        let realm = try! Realm()
        //        Realm_MemoDataModel内の情報を取得
        let result = realm.objects(MemoDataModel.self)
        //        取得したデータを配列に格納
        memoDataList=Array(result)
    }

    @objc func tabAddButton(){
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let memoDetailViewController=storyboard.instantiateViewController(identifier: "MemoDetailViewController")as!
        MemoDetailViewController
        navigationController?.pushViewController(memoDetailViewController, animated:true)
    }


    func setNavigationBarButton(){
        //        #selector(tabAddButton)をインスタンス化
        //        ヘッダーに表示するボタンをタップした際の処理を指定するための#selectorクラス、（）内は実行対象のメソッド※@objc指定
        let buttonActionSelector:Selector=#selector(tabAddButton)
        let rightBarButton=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: buttonActionSelector)
        //        ヘッダー部分にボタンを追加
        navigationItem.rightBarButtonItem=rightBarButton
    }
    func setLeftNavigationBarButton(){
        //        インスタンス化
        let buttonActionSelector:Selector=#selector(didTapColorSettingButton)
        //        colorSettingIconをインスタンス化
        let leftButtonImage=UIImage(named: "colorSettingIcon")
        //        navigationItemに追加するためにUIBarButtonItemをインスタンス化
        let leftButton=UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: buttonActionSelector)
        //        ボタンを作成して、配置
        navigationItem.leftBarButtonItem=leftButton

    }

    //    ボタンをタップした時の動作
    @objc func didTapColorSettingButton(){
        //        タップされたアラートの動作を指定
        let defaultAction=UIAlertAction(title: "デフォルト", style: .default, handler: { _ -> Void in
            self.setThemeColor(type: .default)
        })
        let orangeAction=UIAlertAction(title: "オレンジ", style: .default, handler: { _ ->Void in
            self.setThemeColor(type: .orange)
        })
        let redAction=UIAlertAction(title: "レッド", style: .default, handler: { _ ->Void in
            self.setThemeColor(type: .red)
        })
        let blueAction=UIAlertAction(title: "ブルー", style: .default, handler: { _ ->Void in
            self.setThemeColor(type: .blue)
        })
        let pinkAction=UIAlertAction(title: "ピンク", style: .default, handler: { _ ->Void in
            self.setThemeColor(type: .pink)
        })
        let greenAction=UIAlertAction(title: "グリーン", style: .default, handler: { _ ->Void in
            self.setThemeColor(type: .green)
        })
        let purpleAction=UIAlertAction(title: "パープル", style: .default, handler: { _ ->Void in
            self.setThemeColor(type: .purple)
        })
        

        let cancelAction=UIAlertAction(title: "キャンセル", style:.cancel,handler:nil)
        //        アラート自体のコントローラーをインスタンス化
        let alert = UIAlertController(title: "テーマカラーは？？？", message: "選択してみて", preferredStyle: .actionSheet)
        //        アラート自体にインスタンス化した各要素を追加して使えるように
        alert.addAction(defaultAction)
        alert.addAction(orangeAction)
        alert.addAction(redAction)
        alert.addAction(blueAction)
        alert.addAction(pinkAction)
        alert.addAction(greenAction)
        alert.addAction(purpleAction)
        alert.addAction(cancelAction)

        //      アラートをpresentに渡して表示できるようにする
        present(alert,animated: true)
    }

    func setThemeColor(type:MyColorType){
        let isDefault = type == .default
        let tintColor:UIColor = isDefault ? .black : .white
//        ボタンの色指定
        navigationController?.navigationBar.tintColor=tintColor
        print("setThemeColor",type.color)
//        バーの色を変更_かっこ悪い
//        navigationController?.navigationBar.backgroundColor=type.color
//        これが効かない
//        navigationController?.navigationBar.barTintColor=type.color
//        navigationController?.navigationBar.barTintColor = type.color
        view?.backgroundColor=type.color
        
//        ヘッダーのタイトルテキストを変更
        navigationController?.navigationBar.titleTextAttributes=[NSAttributedString.Key.foregroundColor:tintColor]
        saveThemeColor(type: type)
    }

    func saveThemeColor(type:MyColorType){
        UserDefaults.standard.setValue(type.rawValue, forKey:themeColorTypeKey)
    }

}
//UITableViewの中身を定義する際にHomeViewControllerを拡張してUITableViewDataSourceプロコトルを準拠させる
extension HomeViewController:UITableViewDataSource{

    //    表示する数を指定するメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //UITableViewのリストの数を指定する（memoDataList.countで全て表示している）
        return memoDataList.count
    }

    //    表示する内容をcellに指定するメソッド
    //    テーブルビューが指定されたインデックスパスに対応するセルを取得
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        新しいUITableViewCellのインスタンス化
        //        サブタイトル追加
        //        .subtitleというスタイルは、タイトルラベルとサブタイトルラベルを持つ基本的なセルのレイアウトを提供します。
        //        これにより、メインテキストとサブタイトルテキストを表示することができます
        //        reuseIdentifierは、再利用時にセルを一意に識別するための文字列
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //indexPath.row　=> UITableViewに表示されるCellの０から始まる通り番号が順番に渡される
        let memoDataModel:MemoDataModel=memoDataList[indexPath.row]
        cell.textLabel?.text=memoDataModel.text
        //更新日追加
        cell.detailTextLabel?.text="\(memoDataModel.recordDate)"
        //listの中身を定義する
        return cell
    }
}

//選択されたメモの内容を表示
extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print("indexは\(indexPath.row)です")
        //        Main.storyboardをインスタンス化
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        //        MemoDetailViewControllerもインスタンス化
        let memoDetailViewController=storyboard.instantiateViewController(identifier: "MemoDetailViewController")
        as!MemoDetailViewController
        let memoData=memoDataList[indexPath.row]

        //        MemoDetailViewController.swiftのconfigureに渡してあげる
        memoDetailViewController.configure(memo: memoData)
        //        画面遷移時、選択されたメモをキャンセル（戻った時に選択されたセルがそのままになっているため）
        tableView.deselectRow(at: (indexPath), animated:true)
        //        memoDetailViewControllerに画面遷移
        navigationController?.pushViewController(memoDetailViewController, animated:true)
    }

    //    スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let targetMemo = memoDataList[indexPath.row]
        let realm = try! Realm()
        //        realmからデータを削除
        try! realm.write{
            realm.delete(targetMemo)
        }
        //        memoDataListからデータを削除
        memoDataList.remove(at:indexPath.row)
        //        UIテーブルビューからも削除
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
