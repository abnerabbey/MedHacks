//
//  HistoryViewController.swift
//  MeChat
//
//  Created by Pedro Antonio Vazquez Rodriguez on 09/09/18.
//  Copyright © 2018 Abner Castro. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var lastUserMessage: String?
    
    var tones = [Tone]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Stats"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        tableView.delegate = self
        tableView.dataSource = self
        
        if let lastUserMessage = lastUserMessage {
            let analyzer = URLManager()
            analyzer.performAnalyzeText(text: lastUserMessage, success: { (json) in
                guard let document = json["document_tone"] as? [String: Any], let tone = document["tones"] as? [[String: Any]]  else { return }
                self.tones = tone.map { Tone(json: $0) }
                DispatchQueue.main.async { [weak self] in
                   self?.tableView.reloadData()
                    let view = UIView()
                    view.backgroundColor = UIColor.white
                    self?.tableView.tableFooterView = view
                }
            }) { (error) in
                let alert = UIAlertController(title: "Ups", message: "There was an error. Try it again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableView else { return UITableViewCell () }
        cell.setCell(tone: tones[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}
