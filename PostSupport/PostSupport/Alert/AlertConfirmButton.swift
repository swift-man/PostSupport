//
//  AlertConfirmButton.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct AlertConfirmButton {
  enum Variant {
    case destructive
    case regular
  }
  
  let content: AnyView
  let action: () -> Void
  let type: Variant
  
  var isDestructive: Bool {
    return type == .destructive
  }
  
  static func destructive<Content: View>(
    @ViewBuilder content: @escaping () -> Content
  ) -> AlertConfirmButton {
    AlertConfirmButton(
      content: content,
      action: { /* close */ },
      type: .destructive)
  }
  
  static func regular<Content: View>(
    @ViewBuilder content: @escaping () -> Content,
    action: @escaping () -> Void
  ) -> AlertConfirmButton {
    AlertConfirmButton(
      content: content,
      action: action,
      type: .regular)
  }
  
  private init<Content: View>(
    @ViewBuilder content: @escaping () -> Content,
    action: @escaping () -> Void,
    type: Variant
  ) {
    self.content = AnyView(content())
    self.type = type
    self.action = action
  }
}
