//
//  EditButtonLabel.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import Foundation
import SwiftUI

struct EditButtonLabel: View {
  var body: some View {
    HStack {
      Text("Edit")
      Spacer()
      Image(systemName: "trash")
    }
  }
}
