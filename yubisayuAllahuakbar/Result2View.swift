//
//  Result2View.swift
//  yubisayuAllahuakbar
//
//  Created by Asyifa Tasya Fadilah on 23/05/23.
//

import SwiftUI

struct Result2View: View {
   
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
                
                if result1 == "oily" {
                    Image("OP")
                        .padding(60)
                } else if result1 == "dry"{
                    Image("M")
                        .padding(60)
                }
                else {
                    Image("M")
                        .padding(60)
                }
                
                NavigationLink(destination:CameraCoba())
                                {
                                    Image("Back")
                                }
                                .onTapGesture {
                                camera.reTake()
                                }
                
                }
                
                
            }
            .onAppear{
                result1 = camera.result
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }


struct Result2View_Previews: PreviewProvider {
    static var previews: some View {
        Result2View(camera: CameraModel())
    }
}


