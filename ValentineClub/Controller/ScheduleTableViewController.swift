//
 //  ScheduleTableViewController.swift
 //  ValentineClub
 //
 //  Created by Valentine Education Center on 3/30/23.
 //

 import UIKit
 import Parse

 class ScheduleTableViewController: UITableViewController {
     private var schedules: [PFObject] = [PFObject]()
     let scheduleCell = "ScheduleViewCell"
     let dateFormatter = DateFormatter()
     let todaysDate = Date()

     override func viewDidLoad() {
         dateFormatter.dateFormat = "MM/dd/YY"

         let scheduleQuery = PFQuery(className:"Schedule")
         scheduleQuery.order(byDescending: "scheduleDate")
         do {
             try schedules = scheduleQuery.findObjects()
         } catch {
             print("Game Night retrival error: \(error.localizedDescription)")
         }
     }

 }

extension ScheduleTableViewController {
    
    static let scheduleCell = "ScheduleViewCell"

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schedules.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCell, for: indexPath) as? ScheduleViewCell else { fatalError("Cell Not Found") }
        // Configure the cell...
        let schedule = schedules[indexPath.row]
        let date = schedule["scheduleDate"] as! Date
        let scheduleDate =  dateFormatter.string(from: date)
        let today = dateFormatter.string(from: todaysDate)
        if (today.elementsEqual(scheduleDate)) {
            cell.titleLabel.text = scheduleDate + " (today)"
            
        } else {
            cell.titleLabel.text = scheduleDate
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let schedule = schedules[indexPath.row]
        let scheduleDetailsViewController = segue.destination as! ScheduleDetailsViewController
        
        let file = schedule["file"] as! PFFileObject
        scheduleDetailsViewController.scheduleImageUrl = file.url!
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
