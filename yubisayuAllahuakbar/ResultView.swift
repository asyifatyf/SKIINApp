//
//  ResultView.swift
//  yubisayuAllahuakbar
//
//  Created by Asyifa Tasya Fadilah on 20/05/23.
//

import SwiftUI

struct ResultView: View {
//    @Binding var result: String
//    @Binding var camera: CameraModel
   
    @State var result1 : String = ""
    @StateObject var camera : CameraModel
    
    
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
                        Text("Cleanser                     ")
                            .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                        if result1 == "oily" {
                            Text("facial foam                    ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else if result1 == "dry"{
                            Text("facial wash                    ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else {
                            Text("facial foam                    ")
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
                            Text("gel / non-comedogenic")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else if result1 == "dry"{
                            Text("cream / non-alkohol   ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else {
                            Text("gel / non-comedogenic")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        }
                    }
                }
                
                HStack{
                    Image("Sunscreen")
                        .padding()
                    VStack {
                        Text("Sunscreen                  ")
                            .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                        if result1 == "oily" {
                            Text("physical                       ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else if result1 == "dry"{
                            Text("chemical                       ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        } else {
                            Text("chemical                       ")
                                .font(Font.custom("HiraginoSansGB-W6", size: 20))
                        }
                    }
                }
                
                NavigationLink(destination:CameraCoba())
                {
                    Image("Back")
                }
                .onTapGesture {
                camera.reTake()
                }
            }
            .onAppear{
                result1 = camera.result
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(camera: CameraModel())
    }
}

