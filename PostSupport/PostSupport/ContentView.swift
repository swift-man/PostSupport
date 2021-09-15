//
//  ContentView.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @StateObject var linkStorage: LinkStorage
  @StateObject var iconStorage: IconStorage
  @StateObject var editingTextStorage: EditingTextStorage
  
  @State var text: String = ""
  
  init() {
    let context = PersistenceController.shared.container.viewContext
    let linkStorage = LinkStorage(context: context)
    self._linkStorage = StateObject(wrappedValue: linkStorage)
    
    let iconStorage = IconStorage(context: context)
    self._iconStorage = StateObject(wrappedValue: iconStorage)
    
    let editingTextStorage = EditingTextStorage(context: context)
    self._editingTextStorage = StateObject(wrappedValue: editingTextStorage)
  }
  
  var body: some View {
    HStack(content: {
      IconListView(storage: iconStorage)
        .frame(minWidth: 150, maxWidth: 250)
      LinkListView(storage: linkStorage)
        .frame(minWidth: 150, maxWidth: 250)
      VStack {
        
      }
      TextEditor(text: $text)
        .onChange(of: "", perform: { value in
          print(value)
        }).toolbar(content: {
          Button("Check!!") {
            
          }
        })
      TextEditor(text: .constant("Placeholder"))
        .hidden()
    })
  }
}



//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//  }
//}
