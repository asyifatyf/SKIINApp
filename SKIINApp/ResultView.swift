//
//  ResultView.swift
//
//  Created by Asyifa Tasya Fadilah on 20/05/23.
//

import SwiftUI

struct ResultView: View {
    //    @Binding var result: String
    //    @Binding var camera: CameraModel
    
    @State var result1 : String = ""
    @StateObject var camera : CameraModel
    @State private var isPresented = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                if result1 == "oily" {
                    Image("OILY")
                        .padding(.top)
                } else if result1 == "dry"{
                    Image("DRY")
                        .padding(.top)
                }
                else {
                    Image("NORMAL")
                }
                
                
                HStack{
                    Image("Clean")
                        .padding()
                    VStack {
                        Text("Cleanser                   ")
                            .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                        if result1 == "oily" {
                            Text("facial foam                                ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else if result1 == "dry"{
                            Text("facial wash                                ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else {
                            Text("facial foam                                ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                            
                        }
                    }
                }
                
                HStack{
                    Image("Moist")
                        .padding()
                    VStack {
                        Text("Moisturizer               ")
                            .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                            .fontWeight(.bold)
                        
                        if result1 == "oily" {
                            Text("gel                                            ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else if result1 == "dry"{
                            Text("cream                                       ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else {
                            Text("cream                                       ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        }
                    }
                }
                
                HStack{
                    Image("Sunscreen")
                        .padding()
                    VStack {
                        Text("Sunscreen               ")
                            .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                        if result1 == "oily" {
                            Text("physical                                 ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else if result1 == "dry"{
                            Text("chemical                                 ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else {
                            Text("chemical                                 ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        }
                    }
                }
                
                HStack {
                    NavigationLink(destination:CameraCoba())
                    {
                        Image("Back")
   
                    }
                    .onTapGesture {
                        camera.reTake()
                    }
                    
                    Button(action: {
                        isPresented = true
                    }) {
                        Image(systemName: "questionmark.app.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35)
                            .onChange(of: camera.alert, perform: { newValue in
                                camera.takePic()
                            })
                    }
                    .sheet(isPresented: $isPresented) {
                        ScrollView {
                            InfoPage(result1: result1)
                                .padding()
                        }
                    }
                }
                .onAppear{
                    result1 = camera.result
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(camera: CameraModel())
    }
}

