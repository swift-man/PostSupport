//
//  LinkListView.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/14.
//

import Foundation
import SwiftUI

protocol ListView {
  associatedtype T: NSManagedObject
}

struct LinkListView: View {
  @StateObject var storage: LinkStorage
  @State private var isPresentedAlert = false
  
  @State private var text = ""
  @State private var url = ""
  @State private var process: Process = .add
  @State private var editLink: Link?
  
  var body: some View {
    List {
      Section(header: AddButton(isPresentedAlert: $isPresentedAlert,
                                process: $process,
                                title: "Add Link")) {
        ForEach(storage.links) { item in
          VStack(alignment: .leading, spacing: 0) {
            HStack {
              CellLabels(viewModel: CellLabelsModel(title: item.text!,
                                                    url: item.url!,
                                                    timestamp: item.timestamp!))
            }
            .contextMenu {
              Button(action: {
                delete(link: item)
              }, label: {
                DeleteButtonLabel()
              })
              Button(action: {
                self.editLink = item
                self.process = .edit
                text = item.text!
                url = item.url!
                self.isPresentedAlert.toggle()
              }, label: {
                EditButtonLabel()
              })
            }
          }
        }
      }
    }
    .cutomAlert(isPresented: $isPresentedAlert,
                viewModel: AlertViewModel(),
                content: {
                  AlertContaierView(title: process.title + " " + "Link",
                                    topBinder: $text,
                                    bottomBinder: $url,
                                    topText: ("Title", "Stack"),
                                    bottomText: ("URL", "/stack/"))
                }, actions:
                  [
                    AlertConfirmButton.regular {
                      AlertDoneButton()
                    } action: {
                      switch process {
                      case .edit:
                        edit()
                      case .add:
                        addLink()
                      }
                      
                      reset()
                    },
                    AlertConfirmButton.destructive {
                      AlertCancelButton()
                    }
                  ]
    )
  }
  
  private func reset() {
    text = ""
    url = ""
    editLink = nil
  }
  
  private func addLink() {
    withAnimation {
      storage.addLink(text: text, url: url)
    }
  }
  
  private func edit() {
    guard let link = editLink else { return }
    withAnimation {
      storage.edit(link: link, text: text, url: url)
    }
  }
  
  private func delete(link: Link) {
    withAnimation {
      storage.delete(link: link)
    }
  }
}


