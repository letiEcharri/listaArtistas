//
//  CoreDataManage.swift
//  ListaArtistas
//
//  Created by Leticia on 3/11/17.
//  Copyright © 2017 Leticia. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataProtocol {
    
    func fetchArtists() -> [Artista]
    func storeArtists(idArtist: Int, nameArtist: String, genreArtist: String)
    func deleteAllRecords(entity: String)
    func storeAlbums(idArtist: Int, nameAlbum: String, dateRelease: String, image: String)
    func fetchAlbums() -> [Discografia]
}

class CoreDataManage: CoreDataProtocol {
    
    let artistEntity = "Artist"
    let albumEntity = "Album"
    
    func fetchArtists() -> [Artista] {
        var results: [Artista] = [Artista]()
        
        let fetchRequest = NSFetchRequest<Artist>(entityName: artistEntity)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults{
                    let cArtista = Artista(id: Int(item.id), nombre: item.name!, estilo: item.genre!)
                    results.append(cArtista)
                    //print("ARTISTA: \(String(describing: item.artistId)) - \(String(describing: item.artistName))")
                }
                //return allArtistas
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return results
    }
    
    func storeArtists(idArtist: Int, nameArtist: String, genreArtist: String) {
        let context = getContext()
        
        //retrieve the entity
        let entity =  NSEntityDescription.entity(forEntityName: artistEntity, in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue(idArtist, forKey: "id")
        transc.setValue(nameArtist, forKey: "name")
        transc.setValue(genreArtist, forKey: "genre")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func deleteAllRecords(entity: String) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func storeAlbums(idAlbum: Int, idArtist: Int, nameAlbum: String, dateRelease: String, image: String){
        let context = getContext()
        
        //retrieve the entity
        let entity =  NSEntityDescription.entity(forEntityName: albumEntity, in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        transc.setValue(idAlbum, forKey: "id")
        transc.setValue(idArtist, forKey: "idArtist")
        transc.setValue(nameAlbum, forKey: "name")
        transc.setValue(dateRelease, forKey: "dateRelease")
        transc.setValue(image, forKey: "image")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func fetchAlbums() -> [Discografia]{
        var results: [Discografia] = [Discografia]()
        
        let fetchRequest = NSFetchRequest<Album>(entityName: albumEntity)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults{
                    let newItem = Discografia(id: item.id, idArtista: item.idArtist, nombre: item.name, year: item.dateRelease, caratula: item.image)
                    results.append(newItem)
                }
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return results
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
}
