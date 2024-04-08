//
//  ResultViewController.swift
//  choiceCat
//
//  Created by 邱珮瑜 on 2024/4/8.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var showResult: UILabel!
    var resultPoint: Int!
    
    @IBAction func backToFirstPage(_ sender: Any) {
        //回到最一開始的畫面
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var message = ""
        
        switch resultPoint {
        case 0:
            message = "慘兮兮，加油好嗎？"
        case 100:
            message = "在此封您為維基百科"
        default:
            message = "還行還行～"
        }
        
        showResult.text = "您的得分是\(String(resultPoint))\(message)"
    }

}
