//
//  Question.swift
//  choiceCat
//
//  Created by 邱珮瑜 on 2024/4/8.
//

import Foundation

struct Question {
    var ques: String
    var option: [Option]
}

struct Option {
    var title: String
    var ans: Bool
}
