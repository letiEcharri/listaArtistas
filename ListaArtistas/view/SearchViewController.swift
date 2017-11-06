//
//  SearchViewController.swift
//  ListaArtistas
//
//  Created by Leticia on 3/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var txtSearchField: UITextField!
    var artistas: [Artista] = [Artista]()
    var controller: ArtistsController! = ArtistsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        if txtSearchField.text != ""{
            controller.searchForArtists(view: self,nameArtist: txtSearchField.text!)
        }
    }
    
    func goToArtistList(){
        performSegue(withIdentifier: "segueMainToList", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMainToList"{
            
        }
    }
    

}
