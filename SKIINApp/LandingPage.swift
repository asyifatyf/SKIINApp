//
//  LandingPage.swift
//  yubisayuAllahuakbar
//
//  Created by Asyifa Tasya Fadilah on 23/05/23.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("bg2")
                
                NavigationLink(destination:CameraCoba()){
                    Image("arr")
                }
                .offset(y:250)
            }
        }
    }
}
    
struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
