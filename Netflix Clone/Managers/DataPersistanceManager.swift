//
//  DataPersistanceManager.swift
//  Netflix Clone
//
//  Created by Vladlens Kukjans on 18/03/2023.
//

import Foundation
import UIKit
import CoreData

enum DataBaseError: Error {
    case failedToSaveData
}


class DataPersistanceManager {
    
    static let shared = DataPersistanceManager()
    
    init(){}
    
    func downloadTitleWith(model: Title, complition: @escaping(Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.overview = model.overview
        item.original_name = model.original_name
        item.poster_path = model.poster_path
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
guard case item.vote_avarage = model.vote_avarege else {return}
        
        do {
            try context.save()
            complition(.success(()))
        } catch {
            complition(.failure(DataBaseError.failedToSaveData))
        }
    }
}
