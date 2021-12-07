//
//  ItemTableViewController.swift
//  test
//
//  Created by Saad Zbidi on 29/11/2021.
//

import UIKit

class ItemTableViewController: UITableViewController {

    var items = [Item]()

    override func viewDidLoad() {

        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem

         if let savedItems = loadItems() {

           items = savedItems

         }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! itemTableViewCell

        // Configure the cell...

        let item = items[indexPath.row]

        cell.nameLable.text = item.name

        return cell
    }


    @IBAction func unwindToList(sender: UIStoryboardSegue) {

       let srcViewCon = sender.source as? ViewController

       let item = srcViewCon?.item

       if  (srcViewCon != nil && item?.name != "") {

        if let selectedIndexPath = tableView.indexPathForSelectedRow {

            // Update an existing meal.

            items[selectedIndexPath.row] = item!

            tableView.reloadRows(at: [selectedIndexPath], with: .none)

          }

          else {

            // Add a new meal.

            let newIndexPath = NSIndexPath(row: items.count, section: 0)

            items.append(item!)

            tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)

          }

        saveItems()

       }

    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            // Delete the row from the data source

            items.remove(at: indexPath.row)

            saveItems()

            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {

            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view

        }

    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ShowDetail" {

            let detailVC = segue.destination as! ViewController

            // Get the cell that generated this segue.

            if let selectedCell = sender as? itemTableViewCell {

                let indexPath = tableView.indexPath(for: selectedCell)!

                let selectedItem = items[indexPath.row]

                detailVC.item = selectedItem

            }

          }

         else if segue.identifier == "AddItem" {}
        
    }


    func saveItems() {
        
        do { let isSaved = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)

            try isSaved.write(to: Item.ArchiveURL) }

        catch { print("Failed to save items...") }
    }


    func loadItems() -> [Item]? {

        do {

            let data = try Data(contentsOf: Item.ArchiveURL )

            if let savedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] {

                items = savedItems

            }

        } catch {

            print("Couldn't read file.")

        }

        return items
    }
}
