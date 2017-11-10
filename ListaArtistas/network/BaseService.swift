//
//  BaseService.swift
//  ListaArtistas
//
//  Created by Leticia on 3/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseServiceProtocol {
    func getResultsFromItunes(view: SearchViewController, artista: String)
    func getAlbumsFromArtistFromItunes(view: ArtistsListTableViewController, idArtista: Int)
}

class BaseService: BaseServiceProtocol{
    
    let artistEntity = "Artist"
    let albumEntity = "Album"
    
    var coredata: CoreDataManage! = CoreDataManage()
    
    func getResultsFromItunes(view: SearchViewController, artista: String){
        coredata.deleteAllRecords(entity: artistEntity)
        
        let baseURL: String = "https://itunes.apple.com/search?"
        let musicArtistParam = "entity=musicArtist"
        
        let fullURL = "\(baseURL)\(musicArtistParam)&term=\(artista)"
        
        Alamofire.request(fullURL).responseJSON { response in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? NSDictionary{
                
                //getting the result tag array from json and converting it to NSArray
                if let artistArray = jsonObj?.value(forKey: "results") as? NSArray{
                    //looping through all the elements
                    for artist in artistArray{
                        //converting the element to a dictionary
                        if let artistDict = artist as? NSDictionary{
                            let id: Int = artistDict.value(forKey: "artistId") as! Int
                            let name: String = artistDict.value(forKey: "artistName") as! String
                            var genre: String = "Desconocido"
                            if artistDict.value(forKey: "primaryGenreName") != nil{
                                genre = artistDict.value(forKey: "primaryGenreName") as! String
                            }
                            self.coredata.storeArtists(idArtist: id, nameArtist: name, genreArtist: genre)
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    let controller: ArtistsController = ArtistsController()
                    controller.artistsReadyNotice(view: view)
                })
                
            }
            
        }
    }
    
    func getAlbumsFromArtistFromItunes(view: ArtistsListTableViewController, idArtista: Int){
        coredata.deleteAllRecords(entity: albumEntity)
        
        let fullURL = "https://itunes.apple.com/lookup?id=\(idArtista)&entity=album"
        
        Alamofire.request(fullURL).responseJSON { response in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? NSDictionary{
                
                //getting the result tag array from json and converting it to NSArray
                if let artistArray = jsonObj?.value(forKey: "results") as? NSArray{
                    //looping through all the elements
                    for artist in artistArray{
                        //converting the element to a dictionary
                        if let artistDict = artist as? NSDictionary{
                            if (artistDict.value(forKey: "collectionName") != nil){
                                let idAlbum: Int = artistDict.value(forKey: "collectionId") as! Int
                                let idArtista: Int = artistDict.value(forKey: "artistId") as! Int
                                let collectionName: String = artistDict.value(forKey: "collectionName") as! String
                                let caratula: String = artistDict.value(forKey: "artworkUrl60") as! String
                                
                                let preDate: String = artistDict.value(forKey: "releaseDate") as! String
                                let date1 = preDate.split(separator: "T")
                                let date: String = String(date1[0])
                                
                                self.coredata.storeAlbums(id: idAlbum, idArtist: idArtista, nameAlbum: collectionName, dateRelease: date, image: caratula)
                            }
                            
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    let controller: ArtistsController = ArtistsController()
                    controller.albumsReadyNotice(view: view)
                })
                
            }
            
        }
    }
    
    
}
