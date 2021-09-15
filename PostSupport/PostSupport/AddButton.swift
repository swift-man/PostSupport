//
//  AddButton.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct AddButton: View {
  @Binding var isPresentedAlert: Bool
  @Binding var process: Process
  let title: String
  
  var body: some View {
    Button(action: {
      withAnimation {
        self.process = .add
        self.isPresentedAlert.toggle()
      }
    }) {
      Label(title, systemImage: "plus")
    }
  }
}
