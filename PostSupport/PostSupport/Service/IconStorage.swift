//
//  IconStorage.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/14.
//

import Foundation
import CoreData

extension Icon {
  static func fetch() -> NSFetchRequest<Icon> {
      let request: NSFetchRequest<Icon> = Icon.fetchRequest()
      request.sortDescriptors = [NSSortDescriptor(keyPath: \Icon.timestamp, ascending: false)]

      return request
    }
}

final class IconStorage: NSObject, ObservableObject {
  @Published var icons: [Icon] = []
  private let controller: NSFetchedResultsController<Icon>
  private let context: NSManagedObjectContext

  init(context: NSManagedObjectContext) {
    self.context = context
    controller = NSFetchedResultsController(fetchRequest: Icon.fetch(),
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    controller.delegate = self

    do {
      try controller.performFetch()
      icons = controller.fetchedObjects ?? []
    } catch {
      print("failed to fetch icons!")
    }
  }
  
  func addIcon(text: String, url: String) {
    let newIcon = Icon(context: context)
    newIcon.text = text
    newIcon.url = url
    newIcon.timestamp = Date()
    
    do {
      try context.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  func edit(icon: Icon, text: String, url: String) {
    icon.text = text
    icon.url = url
    icon.timestamp = Date()
    do {
      try context.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  func delete(icon: Icon) {
    context.delete(icon)
    
    do {
      try context.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
}

extension IconStorage: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let changedIcons = controller.fetchedObjects as? [Icon]
      else { return }

    icons = changedIcons
  }
}
