//
//  EditingTextStorage.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import Foundation
import CoreData

extension EditingText {
  static func fetch() -> NSFetchRequest<EditingText> {
      let request: NSFetchRequest<EditingText> = EditingText.fetchRequest()
      request.sortDescriptors = [NSSortDescriptor(keyPath: \EditingText.timestamp, ascending: false)]
      return request
    }
}

final class EditingTextStorage: NSObject, ObservableObject {
  @Published var editText: EditingText?
  private let controller: NSFetchedResultsController<EditingText>
  private let context: NSManagedObjectContext

  init(context: NSManagedObjectContext) {
    self.context = context
    controller = NSFetchedResultsController(fetchRequest: EditingText.fetch(),
                                            managedObjectContext: context,
                                            sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    controller.delegate = self

    do {
      try controller.performFetch()
      editText = controller.fetchedObjects?.first
    } catch {
      print("failed to fetch icons!")
    }
  }
  
  func edit(editingText: EditingText, input: String, output: String) {
    editingText.input = input
    editingText.output = output
    do {
      try context.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
}

extension EditingTextStorage: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let changedEditText = controller.fetchedObjects?.first as? EditingText
      else { return }

    editText = changedEditText
  }
}
