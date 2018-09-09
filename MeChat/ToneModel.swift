//
//  ToneModel.swift
//  MeChat
//
//  Created by Pedro Antonio Vazquez Rodriguez on 09/09/18.
//  Copyright © 2018 Abner Castro. All rights reserved.
//

import Foundation

class Tone {
    var toneID: String?
    var toneName: String?
    var score: Double?
    
    init(json: [String: Any]) {
        self.toneID = json["tone_id"] as? String
        self.toneName = json["tone_name"] as? String
        self.score = json["score"] as? Double
    }
}
