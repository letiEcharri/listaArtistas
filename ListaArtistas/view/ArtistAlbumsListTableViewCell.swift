//
//  ArtistAlbumsListTableViewCell.swift
//  ListaArtistas
//
//  Created by Leticia on 6/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import UIKit

class ArtistAlbumsListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCaratula: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    var idArtist: Int = 0
    var idAlbum: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ArtistAlbumsListTableViewCell{
    
    func display(image: String){
        //let imgImage: UIImage = UIImage(named: image)!
        imgCaratula.image = image.loadImageFromURL()
    }
    
    func display(name: String) {
        lblNombre.text = name
    }
    
    func display(date: Date){
        lblFecha.text = date.formatDate()
    }
}
