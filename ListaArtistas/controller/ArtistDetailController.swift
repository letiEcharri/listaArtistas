//
//  ArtistDetailController.swift
//  ListaArtistas
//
//  Created by Leticia on 5/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import Foundation

protocol ArtistDetailControllerProtocol {
    func searchForAlbums(view: ArtistDetailViewController, idArtist: Int)
    func albumsReadyNotice(view: ArtistDetailViewController)
}

class ArtistDetailController: ArtistDetailControllerProtocol {
    var baseService: BaseServiceProtocol = BaseService()
    
    func searchForAlbums(view: ArtistDetailViewController, idArtist: Int) {
        baseService.getAlbumsFromArtistFromItunes(view: view, idArtista: idArtist)
    }
    
    func albumsReadyNotice(view: ArtistDetailViewController){
        
    }
    
}
