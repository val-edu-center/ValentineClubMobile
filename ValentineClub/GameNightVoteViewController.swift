//
//  GameNightVoteViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 2/18/22.
//

import UIKit
import Parse

class GameNightVoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private var gameNights: [PFObject] = [PFObject]()
    private var userVotes: [PFObject] = [PFObject]()
    private var currentUsername = ""
    let radioButton = "RadioButtonTableViewCell"
    let dateFormatter = DateFormatter()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/YY"
        tableView.delegate = self
        tableView.dataSource = self
        currentUsername = PFUser.current()!.username!
        
        tableView.register(UINib(nibName: radioButton, bundle: nil), forCellReuseIdentifier: radioButton)
        
        let gameNightQuery = PFQuery(className:"GameNight")
        do {
            try gameNights = gameNightQuery.findObjects()
        } catch {
            print("Game Night retrival error: \(error.localizedDescription)")
        }
        
        let gameNightVotesQuery = PFQuery(className:"GameNightVotes")
        gameNightVotesQuery.whereKey("username", equalTo: currentUsername)
        do {
            try userVotes = gameNightVotesQuery.findObjects()
        } catch {
            print(" Game Night Vote retrival error: \(error.localizedDescription)")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gameNights.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let options = gameNights[section]["options"] as! [String]
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1
        guard let cell = tableView.dequeueReusableCell(withIdentifier: radioButton, for: indexPath) as? RadioButtonTableViewCell else { fatalError("Cell Not Found") }
        cell.selectionStyle = .none
        let gameNight = gameNights[indexPath.section]
        let date = gameNight["date"] as! Date
        let gameNightDate =  dateFormatter.string(from: date)
        let options = gameNight["options"] as! [String]
        let option = options[indexPath.row]
        cell.configure(option)
        // 7
        let isSelected = userVotes.contains(where: {
            dateFormatter.string(from: ($0["gameNightDate"] as! Date)) == gameNightDate && ($0["option"] as! String) == option})
        cell.isSelected(isSelected)
        // 8
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! RadioButtonTableViewCell
        cell.setSelected(true, animated: false)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        let gameNight = gameNights[section]
        let date = gameNight["date"] as! Date
        return dateFormatter.string(from: date)
    }

}
