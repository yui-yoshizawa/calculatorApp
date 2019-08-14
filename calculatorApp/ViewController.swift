//
//  ViewController.swift
//  calculatorApp
//
//  Created by 吉澤優衣 on 2019/08/12.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen: Double = 0    // 画面に表示されている数字
    var previousNumber: Double = 0    // 前回表示されていた数字
    var performingMath = false    // 計算プロセスに進んでいいかの判断値（真偽値）
    var operation = 0    // +, -, ×, ÷

    @IBOutlet weak var label: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
    }

    // 数字ボタン
    @IBAction func buttonNum(_ sender: UIButton) {
        if performingMath == true {
            label.text = String(sender.tag)
            numberOnScreen = Double(label.text!)!
            performingMath = false
        } else {
            label.text = label.text! + String(sender.tag)
            numberOnScreen = Double(label.text!)!
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 {    // 数字が表示されていた場合の処理
            // ラベルが空白の時、＝を押した時、Cを押した時以外
            // previousNumber に表示されている数字を代入
            previousNumber = Double(label.text!)!
            
            // ラベルに記号を表示
            if sender.tag == 12 {    // +
                label.text = "÷"
            } else if sender.tag == 13 {    // -
                label.text = "×"
            } else if sender.tag == 14 {    // ×
                label.text = "-"
            } else if sender.tag == 15 {    // ÷
                label.text = "+"
            }
            
            // operation に、押した四則計算のタグ番号を代入
            operation = sender.tag
            
            // 計算できるよー
            performingMath = true
            
        } else if sender.tag == 16 {
            // = が押されたとき
            if operation == 12 {
                let num = String(previousNumber / numberOnScreen).components(separatedBy: ".")
                if num[1] == "0" {
                    // 少数でない時
                    label.text = num[0]
                } else {
                    label.text = String(previousNumber / numberOnScreen)
                }
                
            } else if operation == 13 {
                let num = String(previousNumber * numberOnScreen).components(separatedBy: ".")
                if num[1] == "0" {
                    // 少数でない時
                    label.text = num[0]
                } else {
                    label.text = String(previousNumber * numberOnScreen)
                }
                
            } else if operation == 14 {
                let num = String(previousNumber - numberOnScreen).components(separatedBy: ".")
                if num[1] == "0" {
                    // 少数でない時
                    label.text = num[0]
                } else {
                    label.text = String(previousNumber - numberOnScreen)
                }
                
            } else if operation == 15 {
                let num = String(previousNumber + numberOnScreen).components(separatedBy: ".")
                if num[1] == "0" {
                    // 少数でない時
                    label.text = num[0]
                } else {
                    label.text = String(previousNumber + numberOnScreen)
                }
            }
        } else if sender.tag == 11{
            // C が押されたとき
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
}
