//
//  LoginView.swift
//  Coffe menu
//
//  Created by Ali Murad on 02/09/2022.
//

import SwiftUI

struct LoginView: View {
    @State var showingSignup = false
    @State var showingFinishReg = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State var confrimPassword = ""
    
    var body: some View {
        VStack {
            Text("Sign in")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Email")
                        .fontWeight(.light)
                        .font(.headline)
                    
                        .foregroundColor(Color.black.opacity(0.75))
                        .opacity(0.75)
                    
                    TextField("Enter your email", text: $email)
                    Divider()
                    
                    Text("Password")
                        .fontWeight(.light)
                        .font(.headline)
                        .foregroundColor(Color.black.opacity(0.75))
                        .opacity(0.75)
                    
                    SecureField("Enter your password", text: $password)
                    Divider()
                    
                    if showingSignup {
                        Text("Confirm Password")
                            .fontWeight(.light)
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.75))
                            .opacity(0.75)
                        
                        SecureField("Enter your confirm password", text: $confrimPassword)
                        Divider()
                        
                    }
                }.padding(.bottom, 15)
                    .animation(.easeOut, value: 0.9)
                HStack {
                    Spacer()
                    Button(action: {
                        resetPassword()
                    }, label: {
                        Text("Forgot Password").foregroundColor(Color.gray.opacity(0.5))
                    })
                }
            }.padding(.horizontal, 10)
            
            Button {
                if showingSignup {
                    register()
                } else {
                    signin()
                }
                
                
            } label: {
                Text(showingSignup ? "Sign Up": "Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }.background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 45)
            SignUpView(showSignup: $showingSignup)
            
        }
        .sheet(isPresented: $showingFinishReg) {
            FinishRegistractionView()
        }

    }
    
    private func register() {
        if !email.isEmpty && !password.isEmpty && !confrimPassword.isEmpty {
            if password == confrimPassword {
                FUser.registerUserWith(email: email, password: password) { error in
                    if error != nil {
                        print(",,..Error registering user: \(error!.localizedDescription)")
                        return
                    }
                    print(",,..User has been created")
                    showingSignup.toggle()
                }
                
            } else {
                print(",,..passwords don't match")
            }
        } else {
            print(",,..Email and password must be set")
        }
    }
    private func signin() {
        if !email.isEmpty && !password.isEmpty {
            FUser.loginUserWith(email: email, password: password) { error, isEmailVerified in
                if error != nil {
                    print ("Error in login", error!.localizedDescription)
                    return
                }
                
                if isEmailVerified {
                    if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.showingFinishReg.toggle()
                    }
                } else {
                    print(",,..Kindly verify email")
                }
            }
            
        }
    }
    private func resetPassword() {
        FUser.resetPassword(email: email) { error in
            if error != nil {
                print(",,..Error in reseting password", error!.localizedDescription)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView: View {
    @Binding var showSignup: Bool
    var body: some View {
    
            VStack {
                Spacer()
                if !showSignup {
                HStack(spacing: 8) {
                    Text("Don't have an acouunt?").foregroundColor(Color.gray.opacity(0.5))
                    Button {
                        showSignup.toggle()
                    } label: {
                        Text("Sign Up")
                    }
                    
                }
            }
            }.padding(.top, 25)
        
    }
}
