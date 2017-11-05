//
//  BaseService.swift
//  ListaArtistas
//
//  Created by Leticia on 3/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import Foundation

protocol BaseServiceProtocol {
    func getResultsFromItunes(view: SearchViewController, artista: String)
    func getAlbumsFromArtistFromItunes(view: ArtistDetailViewController, idArtista: Int)
}

class BaseService: BaseServiceProtocol{
    
    var coredata: CoreDataManage! = CoreDataManage()
    
    func getResultsFromItunes(view: SearchViewController, artista: String){
        coredata.deleteAllRecords(entity: "Artist")
        
        let baseURL: String = "https://itunes.apple.com/search?"
        let musicArtistParam = "entity=musicArtist"
        
        let fullURL = "\(baseURL)\(musicArtistParam)&term=\(artista)"
        //creating a NSURL
        let url = NSURL(string: fullURL)
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                //print(jsonObj!.value(forKey: "results")!)
                
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
        }).resume()
    }
    
    func getAlbumsFromArtistFromItunes(view: ArtistDetailViewController, idArtista: Int){
        let fullURL = "https://itunes.apple.com/lookup?id=\(idArtista)&entity=album"
        
        //creating a NSURL
        let url = NSURL(string: fullURL)
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
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
                                let date: String = artistDict.value(forKey: "releaseDate") as! String
                                let caratula: String = artistDict.value(forKey: "artworkUrl60") as! String
                                
                                self.coredata.storeAlbums(idAlbum: idAlbum, idArtist: idArtista, nameAlbum: collectionName, dateRelease: date, image: caratula)
                            }
                            
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    let controller: ArtistDetailController = ArtistDetailController()
                    controller.albumsReadyNotice(view: view)
                })
            }
        }).resume()
    }
}
