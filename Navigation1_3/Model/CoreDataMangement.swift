//
//  CoreDataMangement.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 20.11.2022.
//

import CoreData

class CoreDataMangement {
    
    static let shared = CoreDataMangement()
    
//    init() {
//        realodFolder()
//    }
    
    // MARK: - Core Data Task
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "DataFromNetwork")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //var folders: [Folder] = []

    func realodFolder() -> [Folder] {
        // request to take all info in folder
        let request = Folder.fetchRequest()
        var folders: [Folder] = []
        
        do {
            folders = try persistentContainer.viewContext.fetch(request)
            return folders
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func addFolder(_ nameFile: String, _ imageFile: String, _ detailFile: String) {
        let folder = Folder(context: persistentContainer.viewContext)
        folder.image = imageFile
        folder.name = nameFile
        folder.detail = detailFile
        
        saveContext()
//        realodFolder()
    }
    
    func removeFolder(folder: Folder) {
        persistentContainer.viewContext.delete(folder)
        saveContext()
    }
}
