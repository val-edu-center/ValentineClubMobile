//
//  PrintFormViewController.swift
//  ValentineClub
//
//  Created by Valentine Education Center on 6/28/22.
//

import UIKit
import Parse
class PrintFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var colors: [String] = []
    var selectedColor: String = ""
    
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var yeet: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        colors = ["Blue", "Black", "Green", "Gold", "Clear", "Bronze", "Pink", "Red", "Orange", "Purple", "White"]
        self.yeet.delegate = self
        self.yeet.dataSource = self
        selectedColor = colors[0]
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedColor = colors[row]
    }
    @IBAction func submit(_ sender: Any) {
        createPrint()
    }
    
    //Move to Dao
    private func createPrint() {
        var parseObject = PFObject(className:"Print")

        parseObject["clientUsername"] = PFUser.current()!.username!
        parseObject["description"] = descriptionField.text
        parseObject["color"] = selectedColor

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
              self.dismiss(animated: true, completion: nil)
          } else {
              ErrorMessenger.showErrorMessage(action: "Print creation", error: error, view: self.view)
          }
        }
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
