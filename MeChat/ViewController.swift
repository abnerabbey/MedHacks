//
//  ViewController.swift
//  MeChat
//
//  Created by Pedro Antonio Vazquez Rodriguez on 09/09/18.
//  Copyright © 2018 Abner Castro. All rights reserved.
//


import UIKit
import AssistantV1


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        assistantExample()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func assistantExample() {
                // Assistant credentials
                let username = "f067a060-1a95-48cf-a8ef-4d0186e234e2"
                let password = "kMQL74HmWwgZ"
                let workspace = "a8e428ee-7e51-4a7f-abbc-67bf3aa9eb16"
        
                // instantiate service
                let assistant = Assistant(username: username, password: password, version: "2018-03-01")
        
                // start a conversation
                assistant.message(workspaceID: workspace) { response in
                    print("Conversation ID: \(response.context.conversationID!)")
                    print("Response: \(response.output.text.joined())")
        
                    // continue assistant
                    print("Request: turn the radio on")
                    let input = InputData(text: "turn the radio on")
                    let request = MessageRequest(input: input, context: response.context)
                    assistant.message(workspaceID: workspace, request: request) { response in
                        print("Response: \(response.output.text.joined())")
                    }
                }
            }
}
