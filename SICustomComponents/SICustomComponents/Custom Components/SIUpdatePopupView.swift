//
//  SIUpdatePopupView.swift
//  SICustomComponents
//
//  Created by Nausheen Khan on 12/07/24.
//

import SwiftUI

struct SIUpdatePopupView: View {
    
    enum UpdateType {
        case optionalUpdate
        case forceUpdate
    }
    
    let updateType: UpdateType
    @Binding var isPresented: Bool
    
    var body: some View {
        switch updateType {
        case .optionalUpdate:
            optionalUpdateView
        case .forceUpdate:
            forceUpdateView
        }
    }
    
    private var forceUpdateView: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                Text("Update Required")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("A new version of the app is available. Please update to continue using the app.")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Button {
                    if let url = URL(string: "https://apps.apple.com/us/app/your-app-id") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text("Update Now")
                        .padding(.all, 15)
                }
                .withSIUpdatePopupButtonStyle(forgroundColor: .white, 
                                              backgroundColor: .blue)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.2))
                    .shadow(color: .gray.opacity(0.5),
                            radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
            )
            .frame(width: geometry.size.width * 0.9)
            .frame(maxHeight: geometry.size.height * 0.4)
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
        
    }
    
    private var optionalUpdateView: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                Text("Update Available")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("A new version of the app is available. Would you like to update now?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                HStack() {
                    Button {
                        if let url = URL(string: "https://apps.apple.com/us/app/your-app-id") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Update Now")
                            .frame(maxWidth: .infinity)
                            .padding(.all, 15)
                    }
                    .withSIUpdatePopupButtonStyle(forgroundColor: .white,
                                                  backgroundColor: .blue)
                    
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding(.all, 15)
                    }
                    .withSIUpdatePopupButtonStyle(forgroundColor: .white,
                                                  backgroundColor: .red)
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.2))
                    .shadow(color: .gray.opacity(0.5),
                            radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10)
            )
            .frame(width: geometry.size.width * 0.9)
            .frame(maxHeight: geometry.size.height * 0.4)
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
    }
}

struct SIUpdatePopupButtonStyle: ButtonStyle {
    let forgroundColor: Color
    let backgroundColor: Color
    let cornerRadius: CGFloat
    
    init(forgroundColor: Color, backgroundColor: Color, cornerRadius: CGFloat) {
        self.forgroundColor = forgroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(forgroundColor)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
    }
}

struct SIUpdatePopupViewModifier<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: () -> PopupContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
                .blur(radius: isPresented ? 3 : 0)
            
            if isPresented {
                popupContent()
                    .transition(.scale)
                    .zIndex(1)
            }
        }
    }
}

extension View {
    func updatePopup<PopupContent: View>(isPresented: Binding<Bool>, @ViewBuilder popupContent: @escaping () -> PopupContent) -> some View {
        modifier(SIUpdatePopupViewModifier(isPresented: isPresented, popupContent: popupContent))
    }
    
    func withSIUpdatePopupButtonStyle(forgroundColor: Color = .white, backgroundColor: Color = .blue, cornerRadius: CGFloat = 10) -> some View {
        buttonStyle(SIUpdatePopupButtonStyle(
            forgroundColor: forgroundColor, 
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius))
    }
}

#Preview {
    SIUpdatePopupView(updateType: .forceUpdate,
                      isPresented: .constant(false))
}
