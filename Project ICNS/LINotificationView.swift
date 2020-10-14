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
                    ZStack {
                        VStack {
                            Text(title)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .maxWidth(150)
                            Rectangle()
                                .frame(height: 22)
                                .foregroundColor(.clear)
                        }.padding(.horizontal, 50)
                        VStack {
                            Rectangle()
                                .frame(height: 11)
                                .foregroundColor(.clear)
                            Text(description)
                                .font(.subheadline, weight: .bold)
                                .foregroundColor(.secondary)
                                .lineSpacing(-23)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .maxWidth(240)
                        }.padding(.horizontal, 30)
                        .onSwipeUp {
                            withAnimation(.easeIn(duration: 0.45)) {
                                isPresented = false
                            }
                        }
                    }
                }
                .frame(height: 65)
                .fixedSize(horizontal: true, vertical: false)
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
                                withAnimation(.easeIn(duration: 0.45)) {
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
                                withAnimation(.easeIn(duration: 0.45)) {
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
                            if isPresented {
                                TextField(placeholder, text: $tempText)
                                    .font(.subheadline, weight: .bold)
                                    .foregroundColor(.secondary)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .multilineTextAlignment(.center)
                                    .maxWidth(215)
                            }
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

struct LINotificationActionView: View {
    @Binding var isPresented: Bool
    var title: String
    var buttons: [(uuid: UUID, image: Image, action: () -> ())]
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                ZStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.secondarySystemGroupedBackground)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 0.0)
                    }
                    VStack(spacing: 2) {
                        Text(title)
                            .font(.caption2)
                            .fontWeight(.heavy)
                            .maxWidth(150)
                            .padding(.horizontal, 65)
                        HStack {
                            ForEach(buttons, id: \.uuid) { button in
                                Button {
                                    button.action()
                                    withAnimation(.easeIn(duration: 0.45)) {
                                        isPresented = false
                                    }
                                } label: {
                                    button.image
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }.padding(.vertical, 4)
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
    func notificationPlain(t title: String, d description: String, shown: Binding<Bool>) -> AnyView {
        return AnyView(ZStack {
            self
            LINotificationView(isPresented: shown, title: title, description: description)
        })
    }
    
    func notificationEditor(t title: String, p placeholder: String, input: Binding<String>, temp: String, shown: Binding<Bool>) -> AnyView {
        return AnyView(ZStack {
            self
                .blur(radius: shown.wrappedValue ? 4 : 0)
            LINotificationTextView(isPresented: shown, title: title, text: input, tempText: input.wrappedValue, placeholder: placeholder)
        })
    }
    
    func notificationAction(t title: String, b buttons: [(UUID, Image, () -> ())], shown: Binding<Bool>) -> AnyView {
        return AnyView(ZStack {
            self
                .blur(radius: shown.wrappedValue ? 4 : 0)
            LINotificationActionView(isPresented: shown, title: title, buttons: buttons)
        })
    }
}

typealias LINotificationTextDetails = (to: Binding<String>, title: String, placeholder: String, shown: Bool, temp: String)

struct LINotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("Hello, World!")
            LINotificationView(isPresented: .constant(true), title: "Ben's AirPods", description: "Uh-oh! Something went wrong! I guess. Maybe. Try again later.")
//            LINotificationTextView(isPresented: .constant(true), title: "Write Some Text", text: .constant("Are Awesome!"), tempText: "Are Awesome!", placeholder: "Bundle ID")
//            LINotificationActionView(isPresented: .constant(true), title: "Choose a Photo", buttons: [(UUID(), Image("Cancel"), {}), (UUID(), Image("Photos"), {}), (UUID(), Image("Clipboard"), {}), (UUID(), Image("Files"), {})])
        }
    }
}
