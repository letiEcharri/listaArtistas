//
//  ArtistsListTableViewCell.swift
//  ListaArtistas
//
//  Created by Leticia on 3/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import UIKit

protocol ArtistViewCell {
    func display(name: String)
    func display(genre: String)
    func save(id: Int)
}

class ArtistsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    var idArtist: Int = 0
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //print("ID ARTISTA: \(idArtist)")
    }

}

extension ArtistsListTableViewCell: ArtistViewCell{
    func display(name: String) {
        lblName.text = name
    }
    
    func display(genre: String) {
        lblGenre.text = genre
    }
    
    func save(id: Int){
        idArtist = id
    }
}
