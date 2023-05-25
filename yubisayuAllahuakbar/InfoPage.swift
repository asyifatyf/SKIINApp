//
//  InfoPage.swift
//  yubisayuAllahuakbar
//
//  Created by Asyifa Tasya Fadilah on 25/05/23.
//

import SwiftUI

struct InfoPage: View {
    
    @State var result1 : String = ""
    
    var body: some View {
            ZStack {
            
                VStack {
                    Text("Cleanser")
                        .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                    
                    if result1 == "oily" {
                        Text("Facial foam is formulated to effectively remove excess oil, impurities, and dirt from the skin's surface, leaving it clean and refreshed. Facial foams typically contain ingredients like salicylic acid, tea tree oil, or charcoal, which help to regulate sebum production and reduce the appearance of pores. These foams have a lightweight and non-greasy texture that creates a refreshing lather, effectively removing oil buildup and leaving the skin feeling balanced and matte.")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 250)
                            .padding()
                    } else if result1 == "dry"{
                        Text("Facial wash is a designed to gently cleanse the skin without stripping away its natural oils, providing nourishment and hydration while effectively removing dirt, impurities, and excess oil. These facial washes often contain moisturizing ingredients such as hyaluronic acid, glycerin, or natural oils, which help replenish the skin's moisture barrier and prevent further dryness.")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 250)
                            .padding()
                    } else {
                        Text("nahloh")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 250)
                            .padding()
                    }
                    
                    Text("Moisturizer")
                        .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                    if result1 == "oily" {
                        Text("Gel moisturizer is a lightweight, water-based moisturizing product that provides hydration to the skin without leaving a heavy or greasy residue. It is particularly beneficial for those with oily or combination skin types who prefer a non-comedogenic formula that won't clog pores or contribute to excess oil production.")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 250)
                            .padding()
                        
                    } else if result1 == "dry"{
                        Text("Cream moisturizer is a thicker and richer formulation that is suitable for individuals with dry or mature skin. Cream moisturizers typically have a higher oil content, providing intense hydration and nourishment to replenish moisture in the skin. These moisturizers often contain ingredients like shea butter, ceramides, or natural oils, which help to repair the skin's moisture barrier and lock in hydration.")
                            .padding()
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 250)
                        
                    } else {
                        Text("nahloh")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 250)
                            .padding()
                        
                    }
                    
                    Text("Sunscreen")
                        .font(Font.custom("InstantHarmonyDEMO-Regular", size: 30))
                    if result1 == "oily" {
                        Text("Physical sunscreen is a type of sun protection that works by physically blocking and reflecting UV rays from the skin's surface. It contains active mineral ingredients such as zinc oxide or titanium dioxide, which create a physical barrier on the skin. When applied, these ingredients form a protective layer that scatters and deflects UV radiation, preventing it from penetrating the skin. Physical sunscreens are suitable for all skin types, including sensitive skin, as they are generally less irritating and have a lower risk of causing allergies.")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 300)
                            .padding()
                    } else if result1 == "dry"{
                        Text("Chemical sunscreen works by absorbing UV rays and converting them into heat energy, which is then released from the skin. It contains organic compounds such as avobenzone, oxybenzone, or octinoxate, which penetrate the skin and form a protective shield against the sun's rays. Chemical sunscreens tend to have a lighter texture and are often preferred for daily use under makeup or as part of a skincare routine. They provide effective broad-spectrum protection and can offer more coverage with smaller amounts of product compared to physical sunscreens.")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 300)
                            .padding()
                    } else {
                        Text("nahloh")
                            .font(Font.custom("", size: 18))
                            .frame(width: 350, height: 300)
                            .padding()
                    }
                }
            }
        }
}

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage()
    }
}

