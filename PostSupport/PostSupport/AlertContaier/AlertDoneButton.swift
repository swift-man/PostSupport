//
//  AlertDoneButton.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct AlertDoneButton: View {
  var body: some View {
    HStack {
      Image(systemName: "plus.square.fill")
        .foregroundColor(.green)
      Text("Done")
        .foregroundColor(.green)
    }
  }
}
