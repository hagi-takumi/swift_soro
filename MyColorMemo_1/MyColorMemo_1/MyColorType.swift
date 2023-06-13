//
//  MyColorType.swift
//  MyColorMemo_1
//
//  Created by Takumi_Hagi_BTC4 on 2023/06/13.
//

import Foundation
import UIKit

enum MyColorType:Int{

    case `default`//#ffffff
    case orange //#fda085
    case red //#B70404
    case blue //#11009E
    case pink //#FF78C4
    case green //#00DFA2
    case purple //#9336B4

    var color:UIColor{
        switch self{
        case .default :return .white
        case .orange:return UIColor.rgba(red: 253, green: 160, blue: 133, alpha: 1)
        case .red:return UIColor.rgba(red: 183, green: 4, blue: 4, alpha: 1)
        case .blue:return UIColor.rgba(red: 17, green: 0, blue: 158, alpha: 1)
        case .pink:return UIColor.rgba(red: 255, green: 120, blue: 190, alpha: 1)
        case .green:return UIColor.rgba(red: 0, green: 223, blue: 162, alpha: 1)
        case .purple:return UIColor.rgba(red: 147, green: 54, blue: 180, alpha: 1)
        }
    }
}

extension UIColor {
    static func rgba (red : Int , green : Int , blue : Int , alpha : CGFloat) -> UIColor {
        let result = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
        print("Mycolor",result)
        return result
    }

}
