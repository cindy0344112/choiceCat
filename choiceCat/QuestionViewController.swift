//
//  QuestionViewController.swift
//  choiceCat
//
//  Created by 邱珮瑜 on 2024/4/8.
//

import UIKit

class QuestionViewController: UIViewController {

    //題庫15題
    let questions: [Question] = [
        Question(ques: "貓咪的睡覺時間是多久？", option: [Option(title: "12小時", ans: false), Option(title: "16小時", ans: true), Option(title: "20小時", ans: false), Option(title: "24小時", ans: false) ]),
        Question(ques: "狗狗的嗅覺比人類好多少倍？", option: [Option(title: "5倍", ans: false), Option(title: "10倍", ans: false), Option(title: "100倍", ans: true), Option(title: "1000倍", ans: false) ]),
        Question(ques: "黃金鼠的平均壽命是多久？", option: [Option(title: "1年", ans: false), Option(title: "2年", ans: true), Option(title: "3年", ans: false), Option(title: "5年", ans: false) ]),
        Question(ques: "貓咪的眼睛有幾個眼瞼？", option: [Option(title: "1", ans: false), Option(title: "2", ans: false), Option(title: "3", ans: true), Option(title: "4", ans: false) ]),
        Question(ques: "狗狗的最高品種數量在哪個國家？", option: [Option(title: "美國", ans: true), Option(title: "中國", ans: false), Option(title: "中國", ans: false), Option(title: "英國", ans: false) ]),
        Question(ques: "黃金鼠是哪種動物的親戚？", option: [Option(title: "大象", ans: false), Option(title: "象鼻鼠", ans: true), Option(title: "獅子", ans: false), Option(title: "無尾熊", ans: false) ]),
        Question(ques: "貓咪的聽力範圍是多少Hz到多少Hz？", option: [Option(title: "20Hz 到 20,000Hz", ans: true), Option(title: "1Hz 到 10,000Hz", ans: false), Option(title: "50Hz 到 15,000Hz", ans: false), Option(title: "100Hz 到 25,000Hz", ans: false) ]),
        Question(ques: "狗狗的舌頭有多少種不同的味蕾？", option: [Option(title: "1000", ans: false), Option(title: "5000", ans: false), Option(title: "10,000", ans: true), Option(title: "20,000", ans: false) ]),
        Question(ques: "黃金鼠的毛色是由哪個基因控制的？", option: [Option(title: "黑色素基因", ans: false), Option(title: "紅色素基因", ans: false), Option(title: "棕色素基因", ans: false), Option(title: "黃色素基因", ans: true) ]),
        Question(ques: "貓咪的鬍鬚可以用來做什麼？", option: [Option(title: "測量距離", ans: true), Option(title: "攝取水分", ans: false), Option(title: "切碎食物", ans: false), Option(title: "分泌脂肪", ans: false) ]),
        Question(ques: "狗狗的心跳速率是多少？", option: [Option(title: "60至100次/分鐘", ans: true), Option(title: "100至140次/分鐘", ans: false), Option(title: "40至60次/分鐘", ans: false), Option(title: "140至180次/分鐘", ans: false) ]),
        Question(ques: "黃金鼠的鼻子是什麼形狀的？", option: [Option(title: "圓形", ans: false), Option(title: "方形", ans: false), Option(title: "三角形", ans: false), Option(title: "橢圓形", ans: true) ]),
        Question(ques: "狗狗的汗腺分佈在哪裡？", option: [Option(title: "身體表面", ans: false), Option(title: "舌頭", ans: false), Option(title: "腳墊", ans: true), Option(title: "尾巴", ans: false) ]),
        Question(ques: "黃金鼠的視力比人類差多少？", option: [Option(title: "一半", ans: false), Option(title: "一四分之一", ans: false), Option(title: "一三分之一", ans: true), Option(title: "一十分之一", ans: false) ]),
        Question(ques: "狗狗的嗅覺能力最強的品種是？", option: [Option(title: "德國牧羊犬", ans: true), Option(title: "拉布拉多犬", ans: false), Option(title: "比特犬", ans: false), Option(title: "貴賓犬", ans: false) ])
    ]
    
    var currentQuestion: Int = 1  //當下作答題號
    var getQuestions: [Question] = [] //該場考試的10題
    var point: Int = 0 // 得分
    var questionNum = 10 //所需題數
    
    @IBOutlet weak var showCurrent: UILabel!  //顯示當下題號
    @IBOutlet weak var questionTitle: UILabel!  //題目
    @IBOutlet var optionTitle: [UIButton]!  //選項的collection
    @IBOutlet weak var nextQues: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //取得該場考試的題目
        getQuestions = Array(questions.shuffled().prefix(questionNum))
        //把每一題的選項改變順序
        for i in 0..<getQuestions.count {
            getQuestions[i].option = getQuestions[i].option.shuffled()
        }
        
        // 顯示題目以及選項
        showQuesAndOption(seq: currentQuestion)
    }
    
    @IBAction func optionTapped(_ sender: UIButton) {
        //將所有按鈕取消disabled
        for button in optionTitle {
            button.isEnabled = true
        }
        //將當下被點選的按鈕做disabled，為了做到單選的效果
        sender.isEnabled = false
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "提醒", message: "請選擇答案！", preferredStyle: .alert)
        let okOption = UIAlertAction(title: "好的", style: .default)
        alertController.addAction(okOption)
        present(alertController, animated: true)
    }
    
    //點選下一題按鈕，用當前題號決定是換下一題還是到分數結果頁面
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if currentQuestion == questionNum {  //第10題的時候可以跳頁至ResultViewController
            if findDisabledButtonIndex() == -1 { //如果使用者沒有答題就跳警告
                showAlert()
                return false
            }
            point = point + ((getQuestions[currentQuestion - 1].option[findDisabledButtonIndex()].ans == true) ? 10 : 0); //計算分數
            
            return true
        } else {
            if findDisabledButtonIndex() == -1 { //如果使用者沒有答題就跳警告
                showAlert()
                return false
            } else {
                point = point + ((getQuestions[currentQuestion - 1].option[findDisabledButtonIndex()].ans == true) ? 10 : 0); //計算分數

                //將所有按鈕取消disabled
                for button in optionTitle {
                    button.isEnabled = true
                }
                
                currentQuestion = currentQuestion + 1
                showQuesAndOption(seq: currentQuestion)
                showCurrent.text = String(currentQuestion)
                
                //如果是最後一題了按鈕就不要顯示下一題，應該改為顯示完成
                if currentQuestion == questionNum {
                    nextQues.setTitle("完成", for: .normal)
                }
            }
            return false
        }
    }
    
    // 顯示題目以及選項
    func showQuesAndOption(seq: Int) {
        questionTitle.text = getQuestions[seq - 1].ques
        for i in 0..<getQuestions[seq - 1].option.count {
            optionTitle[i].setTitle("\(i+1). \(getQuestions[seq - 1].option[i].title)", for: .normal)
        }
    }
    
    //到結果頁面時將分數傳過去
    @IBSegueAction func showResultPage(_ coder: NSCoder) -> ResultViewController? {
        let controller = ResultViewController(coder: coder)
        controller?.resultPoint = point
        
        return controller
    }
    
    // 取得當前被點選的選項index，有助於算分
    func findDisabledButtonIndex() -> Int {
        for (index, button) in optionTitle.enumerated() {
            if !button.isEnabled {  //被點選的選項
                return index
            }
        }
        return -1  //沒選，需警告
    }

}
