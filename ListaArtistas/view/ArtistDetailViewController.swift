//
//  ArtistDetailViewController.swift
//  ListaArtistas
//
//  Created by Leticia on 5/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    var topName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = topName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
