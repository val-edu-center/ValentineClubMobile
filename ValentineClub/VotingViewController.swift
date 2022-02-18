//
//  VotingViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 2/15/22.
//

import UIKit
import Parse

var gameNights: [PFObject] = [PFObject]()

class VotingViewController: UITableViewController {

    
    let radioButton = "RadioButtonTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: radioButton, bundle: nil), forCellReuseIdentifier: radioButton)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VotingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameNights.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createVotingView(indexPath: indexPath, gameNight: gameNights[indexPath.row])
    }
    
    private func createVotingView(indexPath: IndexPath, gameNight: PFObject) -> RadioButtonTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: radioButton, for: indexPath) as? RadioButtonTableViewCell else {
                fatalError("Unable to dequeue TransactionCell")
            }
        
        return cell
    }
}
