//
//  IconListView.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/14.
//

import Foundation
import SwiftUI

enum Process {
  case edit
  case add
  
  var title: String {
    switch self {
    case .add:
      return "Add"
    case .edit:
      return "Edit"
    }
  }
}

struct IconListView: View {
  @StateObject var storage: IconStorage
  @State private var isPresentedAlert = false
  @State private var text = ""
  @State private var url = ""
  
  @State private var process: Process = .add
  @State private var editIcon: Icon?
  
  var body: some View {
    
    List {
      Section(header: AddButton(isPresentedAlert: $isPresentedAlert,
                                process: $process,
                                title: "Add Icon")) {
        ForEach(storage.icons) { item in
          VStack(alignment: .leading, spacing: 0) {
            HStack {
              CellLabels(viewModel: CellLabelsModel(title: item.text!,
                                                    url: item.url!,
                                                    timestamp: item.timestamp!))
            }
            .contextMenu {
              Button(action: {
                delete(icon: item)
              }, label: {
                DeleteButtonLabel()
              })
              Button(action: {
                self.editIcon = item
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
                  AlertContaierView(title: process.title + " " + "Icon",
                                    topBinder: $text,
                                    bottomBinder: $url,
                                    topText: ("Title", "Memory"),
                                    bottomText: ("icon Name", "fas csd"))
                }, actions:
                  [
                    AlertConfirmButton.regular {
                      AlertDoneButton()
                    } action: {
                      switch process {
                      case .edit:
                        edit()
                      case .add:
                        addIcon()
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
    editIcon = nil
  }
  
  private func addIcon() {
    withAnimation {
      storage.addIcon(text: text, url: url)
    }
  }
  
  private func edit() {
    guard let icon = editIcon else { return }
    withAnimation {
      storage.edit(icon: icon, text: text, url: url)
    }
  }
  
  private func delete(icon: Icon) {
    withAnimation {
      storage.delete(icon: icon)
    }
  }
}
