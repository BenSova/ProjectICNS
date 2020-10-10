//
//  LINotificationView.swift
//  Project ICNS
//
//  Created by Benjamin Sova on 10/9/20.
//

import SwiftUI

struct LINotificationView: View {
    @Binding var isPresented: Bool
    var title: String
    var description: String
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.systemBackground)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 0.0)
                    VStack {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.horizontal, 50)
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                            .maxWidth(215)
                            .padding(.horizontal, 25)
                    }
                }
                .frame(height: 50)
                .fixedSize(horizontal: false, vertical: false)
            }
            Spacer()
        }.padding()
        .offset(y: isPresented ? 0 : -120)
    }
}

struct LINotificationTextView: View {
    @Binding var isPresented: Bool
    var title: String
    @Binding var text: String
    var placeholder: String
    var body: some View {
        if isPresented {
            VStack {
                ZStack(alignment: .leading) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondarySystemGroupedBackground)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 0.0)
                            .onSwipeUp {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        ZStack {
                            VStack {
                                Text(title)
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .maxWidth(150)
                                Rectangle()
                                    .frame(height: 7)
                                    .foregroundColor(.clear)
                            }.padding(.horizontal, 45)
                            VStack {
                                Rectangle()
                                    .frame(height: 9)
                                    .foregroundColor(.clear)
                                TextField(placeholder, text: $text)
                                    .font(.subheadline, weight: .bold)
                                    .foregroundColor(.secondary)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .maxWidth(215)
                            }.padding(.horizontal, 25)
                        }
                    }
                    .frame(height: 50)
                    .fixedSize(horizontal: true, vertical: false)
                }
                Spacer()
            }.padding()
            .offset(y: isPresented ? 0 : -120)
        }
    }
}

struct LINotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("Hello, World!")
//            LINotificationView(isPresented: .constant(true), title: "Ben's AirPods", description: "Are Awesome!")
            LINotificationTextView(isPresented: .constant(true), title: "Write Some Text", text: .constant("Are Awesome!"), placeholder: "Bundle ID")
        }
    }
}
