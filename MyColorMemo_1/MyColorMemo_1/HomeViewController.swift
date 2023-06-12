//
//  HomeViewController.swift
//  MyColorMemo_1
//
//  Created by Takumi_Hagi_BTC4 on 2023/06/12.
//

import Foundation
//UIに関するクラスが格納されたモジュール
import UIKit

//HomeViewControllerにUIViewControllerを「クラス継承」
class HomeViewController:UIViewController{
    
    @IBOutlet weak var tableView: UITableView!

    var memoDataList:[MemoDataModel]=[]

    override func viewDidLoad() {
        //このクラスの画面が表示される際に呼び出されるメソッド
        //画面の表示・非表示に応じて実行されるメソッドを「ライフサイクルメソッド」と呼ぶ
        //print("HomeViewControllerが表示")
        tableView.dataSource=self
        tableView.tableFooterView=UIView()
        setMemoData()
    }

    func setMemoData(){
        for i in 1...5{
            let memoDataModel=MemoDataModel(text:"このメモは\(i)番目のメモです",recordDate: Date())
            memoDataList.append(memoDataModel)
        }
    }
}

extension HomeViewController:UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //UITableViewのリストの数を返す
        return memoDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //サブタイトル追加
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //indexPath.row=>UITableViewに表示されるCellの０から始まる通り番号が順番に渡される
        let memoDataModel:MemoDataModel=memoDataList[indexPath.row]
        cell.textLabel?.text=memoDataModel.text
        //更新日追加
        cell.detailTextLabel?.text="\(memoDataModel.recordDate)"
        //listの中身を定義する
        return cell
    }
}

