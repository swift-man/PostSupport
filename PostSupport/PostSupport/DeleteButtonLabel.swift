//
//  DeleteButtonLabel.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct DeleteButtonLabel: View {
  var body: some View {
    HStack {
      Text("Delete")
      Spacer()
      Image(systemName: "trash")
    }
  }
}
