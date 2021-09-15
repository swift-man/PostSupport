//
//  CellLabels.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct CellLabels: View {
  var viewModel: CellLabelsModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: nil, content: {
      Text(viewModel.title)
        .font(.title)
      Text(viewModel.url)
        .font(.callout)
      Text(viewModel.timestamp)
        .font(.subheadline)
    })
  }
}
