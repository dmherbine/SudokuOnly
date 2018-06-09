//
//  FavGamesManager.swift
//  Sudoku
//
//  Created by dave herbine on 7/23/16.
//  Copyright © 2016 dave herbine. All rights reserved.
//

import UIKit

//var selectedFavIndex: Int? = nil

class FavGamesManager: UITableViewController {

    var favGames = [PersistFavGames]()
    var selectedFavIndex: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)   // eliminate empty cell views
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favGames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favGameName", for: indexPath)  // "favGameName" must be valued in the Storyboard as well!!

        cell.textLabel?.text = favGames[indexPath.row].sFavName != "" ? favGames[indexPath.row].sFavName : "You Don't Have Any Favorite Games"
        var subTitle = "Challenge Level: \(favGames[indexPath.row].pSet.cLevel+1)"
        if let sAlgo = favGames[indexPath.row].pSet.solvingAlgorithm  {
            switch sAlgo {
            case .solvedByCP:
                subTitle += ", Solved by Constraint Propogation"
            case .solvedByPairs:
                subTitle += ", Solved by Pairs and Constraint Propogation"
            case .solvedByDF:
                subTitle += ", Solved by Trial and Error"
            case .solvedByT1UR:
                subTitle += ", Solved by Type 1 Unique Rectangle"
            }
        }
        cell.detailTextLabel?.text = subTitle

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //print("FavGamesManager: didSelectRowAtIndexPath = \(indexPath.row) and favGames.count = \(favGames.count)")
        self.selectedFavIndex = indexPath.row
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            favGames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            var favGame: PersistFavGames? = nil
            if let indexPath = tableView.indexPath(for: cell) {
                if indexPath.row <= favGames.count {
                    favGame = favGames[indexPath.row]
                }
            }
            if let destinationVC = segue.destination as? CVController {
                destinationVC.favGames = favGames   // in case of deletions
                destinationVC.favoriteGame = favGame
            }
        } else {    // Must have canceled
            if let destinationVC = segue.destination as? CVController {
                destinationVC.favGames = favGames   // in case of deletions
            }
        }
    }
    

}
