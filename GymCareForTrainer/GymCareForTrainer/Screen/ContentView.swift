//
//  ContentView.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 12/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showTabbarView = false
    @State private var showRegisterView = false
    @State var isNavigationBarHidden: Bool = true
    @State var isHidden: Bool = true
    @State private var phone: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("coach")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding(50)
                        .foregroundColor(.main_color)
                }
                VStack {
                    TextField("Nhập email hoặc số điện thoại", text: $phone)
                        .textFieldStyle(CustomTextField(systemImageString: "envelope.fill"))
                        .padding(.bottom)
                    SecureField("Nhập mật khẩu", text: $password)
                        .textFieldStyle(CustomTextField(systemImageString: "lock.fill"))
                        .padding(.bottom)
                }
                
                VStack {
                    NavigationLink(destination: TabbarView(), isActive: $showTabbarView) {
                        EmptyView()
                    }
                    .isDetailLink(false)
                    .hidden()
                    Button("Đăng nhập", action: {
                        let viewModel = LoginViewModel()
                        viewModel.callApiLogin(email: $phone.wrappedValue, pass: $password.wrappedValue) { success, error in
                            if success {
                                self.showTabbarView = true
                            } else {
                                self.showTabbarView = false
                            }
                        }
                    })
                    .padding()
                    .background(Color.main_color)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .font(.system(size: 16, weight: Font.Weight.bold))
                    .frame(width: 300)
                    
                }
                .background(Color.main_color)
                .clipShape(Capsule())
                .padding(10)
                
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
            }
            .padding()
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            self.isNavigationBarHidden = true
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
