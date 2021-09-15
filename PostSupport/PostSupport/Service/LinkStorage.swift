//
//  LinkStorage.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/14.
//

import Foundation
import CoreData

extension Link {
  static func fetch() -> NSFetchRequest<Link> {
      let request: NSFetchRequest<Link> = Link.fetchRequest()
      request.sortDescriptors = [NSSortDescriptor(keyPath: \Link.timestamp, ascending: false)]

      return request
    }
}

final class LinkStorage: NSObject, ObservableObject {
  @Published var links: [Link] = []
  private let controller: NSFetchedResultsController<Link>
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.context = context
    
    controller = NSFetchedResultsController(fetchRequest: Link.fetch(),
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil, cacheName: nil)

    super.init()

    controller.delegate = self

    do {
      try controller.performFetch()
      links = controller.fetchedObjects ?? []
    } catch {
      print("failed to fetch links!")
    }
  }
  
  func addLink(text: String, url: String) {
    let newLink = Link(context: context)
    newLink.text = text
    newLink.url = url
    newLink.timestamp = Date()
    
    do {
      try context.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  func edit(link: Link, text: String, url: String) {
    link.text = text
    link.url = url
    link.timestamp = Date()
    do {
      try context.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  func delete(link: Link) {
    context.delete(link)
    
    do {
      try context.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
}

extension LinkStorage: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let changedLinks = controller.fetchedObjects as? [Link]
      else { return }

    links = changedLinks
  }
}
