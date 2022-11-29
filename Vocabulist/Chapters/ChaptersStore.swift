//
//  ChaptersStore.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 29.11.22.
//

import CoreData

class ChaptersStore: NSObject, ObservableObject {
    
    @Published var chapters: [Chapter] = []
    
    private let context: NSManagedObjectContext
    private let fetchRequest: NSFetchRequest<Chapter>
    private let fetchController: NSFetchedResultsController<Chapter>
    
    override init() {
        context = PersistenceController.shared.container.viewContext
        fetchRequest = Chapter.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Chapter.creationDate, ascending: true)]
        fetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        fetchController.delegate = self
    }
    
    func loadAllChapters() {
        try? fetchController.performFetch()
        chapters = fetchController.fetchedObjects ?? []
    }
    
    func addChapter(withTitle title: String) {
        let chapter = Chapter(context: context)
        chapter.title = title
        chapter.creationDate = Date()
        try? context.save()
    }
    
    func editChapter(_ chapter: Chapter, withTitle title: String) {
        chapter.title = title
        try? context.save()
    }
    
    func deleteChapter(_ chapter: Chapter) {
        context.delete(chapter)
        try? context.save()
    }
}

// MARK: - Fetched results controller delegate

extension ChaptersStore: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        loadAllChapters()
    }
}
