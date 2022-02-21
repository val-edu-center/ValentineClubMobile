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
    private var oldUserVoteMap: [String:String] = [:]
    private var userVoteMap: [String:String] = [:]
    let radioButton = "RadioButtonTableViewCell"
    let dateFormatter = DateFormatter()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/YY"
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: radioButton, bundle: nil), forCellReuseIdentifier: radioButton)
        
        let gameNightQuery = PFQuery(className:"GameNight")
        do {
            try gameNights = gameNightQuery.findObjects()
        } catch {
            print("Game Night retrival error: \(error.localizedDescription)")
        }
        
        let gameNightVotesQuery = PFQuery(className:"GameNightVotes")
        gameNightVotesQuery.whereKey("username", equalTo: PFUser.current()!.username!)
        do {
            try userVoteMap = loadUserVoteMap(userVotes: gameNightVotesQuery.findObjects())
            oldUserVoteMap = userVoteMap
        } catch {
            print(" Game Night Vote retrival error: \(error.localizedDescription)")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        userVoteMap.keys.filter({ gameNightDate in return oldUserVoteMap[gameNightDate] != userVoteMap[gameNightDate]})
            .forEach({ gameNightDate in
                var parseObject = PFObject(className:"GameNightVotes")

                parseObject["username"] = PFUser.current()!.username!
                parseObject["option"] = userVoteMap[gameNightDate]
                parseObject["gameNightDate"] = gameNightDate

                // Saves the new object.
                parseObject.saveInBackground {
                  (success: Bool, error: Error?) in
                  if (success) {
                    // The object has been saved.
                  } else {
                      print("Game Night Vote creation error: \(error?.localizedDescription)")
                  }
                }
            })
        self.dismiss(animated: true, completion: nil)
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
        cell.isSelected(isSelected(gameNightDate: gameNightDate, option: option))
        // 8
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameNight = gameNights[indexPath.section]
        let date = gameNight["date"] as! Date
        let gameNightDate =  dateFormatter.string(from: date)
        let options = gameNight["options"] as! [String]
        let option = options[indexPath.row]
        
        userVoteMap[gameNightDate] = option
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        let gameNight = gameNights[section]
        let date = gameNight["date"] as! Date
        return dateFormatter.string(from: date)
    }
    
    private func isSelected(gameNightDate: String, option: String) -> Bool{
        return userVoteMap[gameNightDate]?.elementsEqual(option) ?? false
    }
    
    private func loadUserVoteMap(userVotes: [PFObject]) -> [String: String]{
       return gameNights.reduce([String: String]()) { (dict, gameNight) -> [String: String] in
            var dict = dict
            let date = gameNight["date"] as! Date
            let gameNightDate =  dateFormatter.string(from: date)
            
            let lastVote = userVotes.last(where: {
                let voteGameNightDate = $0["gameNightDate"] as! String
                return voteGameNightDate.elementsEqual(gameNightDate)
            })
            
            if (lastVote != nil) {
                dict[gameNightDate] = lastVote!["option"] as? String
            }
            return dict
        }
    }

}
