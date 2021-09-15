//
//  AlertViewModel.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct AlertViewModel {
  let backgroundColor: Color
  let contentBackgroundColor: Color
  let contentPadding: CGFloat
  let contentCornerRadius: CGFloat
  
  init(backgroundColor: Color = Color.gray, //.opacity(0.4),
       contentBackgroundColor: Color = Color.white, //.opacity(0.8),
       contentPadding: CGFloat = 16,
       contentCornerRadius: CGFloat = 12) {
    self.backgroundColor = backgroundColor
    self.contentBackgroundColor = contentBackgroundColor
    self.contentPadding = contentPadding
    self.contentCornerRadius = contentCornerRadius
  }
}




