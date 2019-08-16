//
//  ViewController.swift
//  calculatorApp
//
//  Created by 吉澤優衣 on 2019/08/12.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// 画面に表示されている数字
    var numberOnScreen: Double = 0
    /// 前回表示されていた数字
    var previousNumber: Double = 0
    /// +, -, ×, ÷
    var operation: String = ""
    /// 計算結果を入れる
    var result: Double = 0
    /// 数値が入力されたかどうかの判断
    var inValue: Bool = false
    /// 計算してもいいかどうかの判断
    var performingMath: Bool = false
    /// ラベルを編集できるかどうか
    var editLabel: Bool = true

    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
    }
    
    // 【数字ボタンを押した時】の処理
    @IBAction func buttonNum(_ sender: UIButton) {
        // 演算結果の上書き防止
        if editLabel {
            if performingMath {
                label.text = String(sender.tag)    // ラベルに押したボタンの数字を表示
                numberOnScreen = Double(label.text!)!    // 表示されている数字を代入
                performingMath = false
            } else {
                label.text = label.text! + String(sender.tag)    // 既に表示されている数字におした数字を追加
                numberOnScreen = Double(label.text!)!    // 表示されている数字を代入
            }
        }
        inValue = true    // 数値が入力されましたー！
    }

    
    // 【記号ボタンを押した時】の処理
    @IBAction func buttonAction(_ sender: UIButton) {
        editLabel = true    // ラベル書き換え可能
        if sender.currentTitle == "C" {
            // 【Cが押されたとき】
            // クリアする
            allClear()
        } else if inValue && sender.currentTitle == "="  {
            // 【= が押されたとき】
            switch operation {
            case "÷":
                result = previousNumber / numberOnScreen
            case "×":
                result = previousNumber * numberOnScreen
            case "+":
                result = previousNumber + numberOnScreen
            case "-":
                result = previousNumber - numberOnScreen
            default:
                break
            }
            // 整数にできるかどうか判断で使う。
            let num: [String] = String(result).components(separatedBy: ".")

            // 計算結果が無限ではない、かつ整数である時
            if !result.isInfinite && num.last == "0" {
                // 小数ではないとき
                label.text = String(Int(result))
            } else {
                // 小数のとき
                label.text = String(result)
            }

            // 数値が入っている
            inValue = true
            // 数値を足せないようにする
            editLabel = false
        } else {
            // 【+, -, ×, ÷ が押されたとき】
            // 画面に表示されている数字を変数に代入
            if inValue {
                previousNumber = Double(label.text!)!
            }
            // 「 = 」以外の演算子を表示
            if sender.currentTitle != "=" {
                label.text = sender.currentTitle
            }
            inValue = false    // 数値は入っていないよー
            operation = sender.currentTitle!    // 演算子を覚える
            performingMath = true    // 計算できるよー
        }
    }

    /// クリアする関数
    func allClear() {
        label.text = ""
        result = 0
        previousNumber = 0
        numberOnScreen = 0
        operation = ""
        inValue = false
        editLabel = true
        performingMath = false
    }
}
