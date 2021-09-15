//
//  CustomAlert.swift
//  PostSupport
//
//  Created by SwiftMan on 2021/09/15.
//

import SwiftUI

struct CustomAlert<Presenter, Content>: View where Presenter: View, Content: View {
  @Binding private (set) var isPresented: Bool
  
  let displayContent: Content
  let buttons: [AlertConfirmButton]
  let presentationView: Presenter
  let viewModel: AlertViewModel
  
  private var requireHorizontalPositioning: Bool {
    let maxButtonPositionedHorizontally = 2
    return buttons.count > maxButtonPositionedHorizontally
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        backgroundColor()
        
        VStack {
          ZStack {
            presentationView.disabled(isPresented)
            let expectedWidth = geometry.size.width * 0.7
            
            VStack {
              displayContent
              buttonsPad(expectedWidth)
            }
            .padding(viewModel.contentPadding)
            .background(viewModel.contentBackgroundColor)
            .cornerRadius(viewModel.contentCornerRadius)
            .shadow(radius: 1)
            .opacity(self.isPresented ? 1 : 0)
            .frame(
              minWidth: expectedWidth,
              maxWidth: expectedWidth
            )
          }
        }
      }
    }
  }
  
  private func backgroundColor() -> some View {
    viewModel.backgroundColor
      .edgesIgnoringSafeArea(.all)
      .opacity(self.isPresented ? 1 : 0)
  }
  
  private func buttonsPad(_ expectedWidth: CGFloat) -> some View {
    VStack {
      if requireHorizontalPositioning {
        verticalButtonPad()
      } else {
        Divider().padding([.leading, .trailing], -viewModel.contentPadding)
        horizontalButtonsPadFor(expectedWidth)
      }
    }
  }
  
  private func verticalButtonPad() -> some View {
    VStack {
      ForEach(0..<buttons.count) {
        Divider().padding([.leading, .trailing], -viewModel.contentPadding)
        let current = buttons[$0]
        
        Button(action: {
          if !current.isDestructive {
            current.action()
          }
          
          withAnimation {
            self.isPresented.toggle()
          }
        }, label: {
          current.content.frame(height: 35)
        })
      }
    }
  }
  
  private func horizontalButtonsPadFor(_ expectedWidth: CGFloat) -> some View {
    HStack {
      let sidesOffset = viewModel.contentPadding * 2
      let maxHorizontalWidth = requireHorizontalPositioning ?
        expectedWidth - sidesOffset :
        expectedWidth / 2 - sidesOffset
      
      Spacer()
      
      if !requireHorizontalPositioning {
        ForEach(0..<buttons.count) {
          if $0 != 0 {
            Divider().frame(height: 44)
          }
          let current = buttons[$0]
          
          Button(action: {
            if !current.isDestructive {
              current.action()
            }
            
            withAnimation {
              self.isPresented.toggle()
            }
          }, label: {
            current.content
          })
          .frame(maxWidth: maxHorizontalWidth, minHeight: 44)
        }
      }
      Spacer()
    }
  }
}

extension View {
  func cutomAlert<Content>(
    isPresented: Binding<Bool>,
    viewModel: AlertViewModel,
    @ViewBuilder content: @escaping () -> Content,
    actions: [AlertConfirmButton]
  ) -> some View where Content: View {
    CustomAlert(
      isPresented: isPresented,
      displayContent: content(),
      buttons: actions,
      presentationView: self,
      viewModel: viewModel)
  }
}
