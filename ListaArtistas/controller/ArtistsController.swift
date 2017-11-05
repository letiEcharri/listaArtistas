//
//  ArtistsController.swift
//  ListaArtistas
//
//  Created by Leticia on 5/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import Foundation

protocol ArtistsControllerProtocol {
    func searchForArtists(view: SearchViewController, nameArtist: String)
    func artistsReadyNotice(view: SearchViewController)
    func getArtists() -> [Artista]
}

class ArtistsController: ArtistsControllerProtocol {

    let coreData: CoreDataManage = CoreDataManage()
    var baseService: BaseServiceProtocol = BaseService()
    
    func searchForArtists(view: SearchViewController, nameArtist: String){
        baseService.getResultsFromItunes(view: view, artista: nameArtist)
    }
    
    func artistsReadyNotice(view: SearchViewController){
        view.artistas = getArtists()
        view.goToArtistList()
    }
    
    func getArtists() -> [Artista] {
        return coreData.fetchArtists()
    }
}
