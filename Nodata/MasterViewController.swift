//
//  MasterViewController.swift
//  Nodata
//
//  Created by Admin on 10/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var number = Array(1...10)
    
    @IBOutlet weak var addd: UIBarButtonItem!
    
    @IBOutlet weak var footView: UIView!
    @IBOutlet var noData: UIView!
    var hasNodata: Bool = false {
        didSet {
            tableView.tableFooterView = hasNodata ? footView : noData
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return number.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(number[indexPath.row])
        // Configure the cell...

        return cell
    }
    

   

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle	 == .delete {
            number.remove(at: indexPath.row)
           if number.count == 0 {
            hasNodata = false
           }else {
            hasNodata = true
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let masterControler = segue.destination as? DetailViewController {
            if let index = tableView.indexPathForSelectedRow {
                masterControler.name = String(number[index.row])
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    @IBAction  func unwind(for unwindSegue: UIStoryboardSegue) {
        if let detailViewContronler = unwindSegue.source as? DetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                number[indexPath.row] = Int(detailViewContronler.name ?? "") ?? 0
            }else {
                number.append(Int(detailViewContronler.name ?? "") ?? 0)
            }
        }
        tableView.reloadData()
    }

}
