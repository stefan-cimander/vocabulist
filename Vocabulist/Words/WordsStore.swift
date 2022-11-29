//
//  WordsStore.swift
//  Vocabulist
//
//  Created by Stefan Cimander on 27.11.22.
//

import CoreData

class WordsStore: NSObject, ObservableObject {
    
    @Published var words: [Word] = []
    
    private let context: NSManagedObjectContext
    private let fetchRequest: NSFetchRequest<Word>
    private let fetchController: NSFetchedResultsController<Word>
    
    override init() {
        context = PersistenceController.shared.container.viewContext
        fetchRequest = Word.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Word.creationDate, ascending: true)]
        fetchController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        fetchController.delegate = self
    }
    
    func loadAllWords() {
        try? fetchController.performFetch()
        words = fetchController.fetchedObjects ?? []
    }
    
    func addWord(with input: AddWordInput, to chapter: Chapter) {
        let word = Word(context: context)
        word.foreignName = input.foreignName
        word.nativeName = input.nativeName
        word.creationDate = Date()
        word.level = 1
        word.chapter = chapter
        try? context.save()
    }
    
    func deleteWords(_ words: [Word]) {
        words.forEach(context.delete)
        try? context.save()
    }
}

// MARK: - Fetched results controller delegate

extension WordsStore: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        loadAllWords()
    }
}
