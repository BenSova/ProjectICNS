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
    @State var tempText: String
    var placeholder: String
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                ZStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondarySystemGroupedBackground)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 0.0)
                        HStack {
                            Button {
                                withAnimation {
                                    isPresented = false
                                }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }
                            Spacer()
                            Button {
                                text = tempText
                                withAnimation {
                                    isPresented = false
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                        }.padding()
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
                        }.padding(.horizontal, 60)
                        VStack {
                            Rectangle()
                                .frame(height: 9)
                                .foregroundColor(.clear)
                            TextField(placeholder, text: $tempText)
                                .font(.subheadline, weight: .bold)
                                .foregroundColor(.secondary)
                                .textFieldStyle(PlainTextFieldStyle())
                                .multilineTextAlignment(.center)
                                .maxWidth(215)
                        }.padding(.horizontal, 45)
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

extension View {
    func notificationEditor(t title: String, p placeholder: String, input: Binding<String>, temp: String, shown: Binding<Bool>) -> AnyView {
        return AnyView(ZStack {
            self
            if shown.wrappedValue {
                LINotificationTextView(isPresented: shown, title: title, text: input, tempText: temp, placeholder: placeholder)
            }
        })
    }
}

typealias LINotificationTextDetails = (to: Binding<String>, title: String, placeholder: String, shown: Bool, temp: String)

struct LINotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("Hello, World!")
//            LINotificationView(isPresented: .constant(true), title: "Ben's AirPods", description: "Are Awesome!")
            LINotificationTextView(isPresented: .constant(true), title: "Write Some Text", text: .constant("Are Awesome!"), tempText: "Are Awesome!", placeholder: "Bundle ID")
        }
    }
}