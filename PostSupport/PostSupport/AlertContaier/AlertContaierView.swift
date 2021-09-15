//
//  AlertContaierView.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct AlertContaierView: View {
  let title: String
  @Binding var topBinder: String
  @Binding var bottomBinder: String
  
  let topText: (title: String, placeholder: String)
  let bottomText: (title: String, placeholder: String)
  
  var body: some View {
    Text(title)
      .foregroundColor(.black)
      .font(.title)
    Divider().frame(height: 5)
    VStack(alignment: .leading, spacing: 1, content: {
      Text(topText.title)
        .foregroundColor(.black)
        .background(Color.white)
        .font(.caption)
      TextField(topText.placeholder, text: $topBinder)
        .foregroundColor(.black)
        .background(Color.black.opacity(0.4))
        .cornerRadius(5.0)
    })
    
    VStack(alignment: .leading, spacing: 1, content: {
      Text(bottomText.title)
        .foregroundColor(.black)
        .font(.caption)
      TextField(bottomText.placeholder, text: $bottomBinder)
        .foregroundColor(.black)
        .background(Color.black.opacity(0.4))
//        .border(Color.black)
        .cornerRadius(5.0)
    })
  }
}



