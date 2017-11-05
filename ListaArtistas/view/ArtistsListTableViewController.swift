//
//  ArtistsListTableViewController.swift
//  ListaArtistas
//
//  Created by Leticia on 3/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import UIKit

class ArtistsListTableViewController: UITableViewController {
    
    var searchController: SearchViewController!
    var artists: [Artista] = [Artista]()
    var nameArtistSelected: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print("NUMERO FILAS: \(artists.count)")
        self.tableView.rowHeight = 83
        self.tableView.separatorColor = UIColor.red
        self.title = "ARTISTAS"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let controller: ArtistsController = ArtistsController()
        artists = controller.getArtists()
    }
    
    @IBAction func newSearch(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistsListTableViewCell
        
        // Configure the cell...
        cell.display(name: artists[indexPath.row].nombre)
        cell.display(genre: artists[indexPath.row].estilo)
        cell.save(id: artists[indexPath.row].id)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameArtistSelected = artists[indexPath.row].nombre
        performSegue(withIdentifier: "segueListToDetail", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        
        if segue.identifier == "segueListToDetail"{
            let view = segue.destination as! ArtistDetailViewController
            view.topName = nameArtistSelected
        }
    }
    

}
