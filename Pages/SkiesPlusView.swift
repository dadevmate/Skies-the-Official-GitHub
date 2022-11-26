//
//  SkiesPlusView.swift
//  Skymie
//
//  Created by Nethan on 23/11/22.
//

import SwiftUI
import RevenueCat
struct SkiesPlusView: View {
    @State var currentOffering: Offering?
    @StateObject var subscriptionModel = SubscriptionModel()
    @State var notAvailableYet = true
    @ObservedObject var subModel: SubscriptionModel
    var body: some View {
        
   
        
        ZStack {
            LinearGradient(colors: [.blue, .cyan, .purple, .black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Text("Skies+")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                    Text("One subscription. A lot of fun.")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                    Spacer()
                    
                    
                    
                    Text("Sign up to Skies+, and enhance your\n                  experience today!")
                        .foregroundColor(.white)
                    
                    
                  
                        
               
                        
                        
                        
                        
                        if subModel.isSubscriptionActive == false {
                            
                            if currentOffering != nil {
                                
                                ForEach(currentOffering!.availablePackages) { pkg in
                                    Button {
                                        Purchases.shared.purchase(package: pkg) { (transaction, customerInfo, error, userCancelled) in
                                            if customerInfo?.entitlements.all["tier 1"]?.isActive == true {
                                                subModel.isSubscriptionActive = true
                                            }
                                        }
                                    } label: {
                                        VStack {
                                            
                                            Group {
                                                HStack {
                                                    Spacer()
                                                    Text("Tier 1:")
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                    Spacer()
                                                    
                                                    Text("\nYou get access to...\n\n- A special badge\n\n- Special Emojis\n\n - A set of exclusive profile pictures\n\n")
                                                        .foregroundColor(.white)
                                                        .fontWeight(.light)
                                                    Spacer()
                                                }
                                            }
                                            .background(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                                            .cornerRadius(10)
                                            .frame(width: 300, height: 200)
                                        }
                                    }
                                }
                                
                                
                                Button {
                                    
                                } label: {
                                    VStack {
                                        
                                        Group {
                                            HStack {
                                                Spacer()
                                                Text("Tier 2:")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                    .font(.largeTitle)
                                                Spacer()
                                                
                                                Text("\nYou get access to...\n\n- Everything in Tier 1\n\n- Stickers\n\n - 2 more special emojis")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.light)
                                                Spacer()
                                            }
                                        }
                                        .background(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom))
                                        .cornerRadius(10)
                                        .frame(width: 300, height: 200)
                                    }
                                }
                            }
                            
                            Text("* Once subscribed, you can access your benefits\naround the app (In messages, posts, settings etc.)")
                                .font(.caption)
                                .foregroundColor(.white)
                            
                        } else {
                            Spacer()
                            Text("You're subscribed!")
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("* Cancel subscription in the Settings app.")
                                .fontWeight(.light)
                                .font(.caption)
                        }
                    
                }
            }
            .onAppear {
                
                if notAvailableYet == false {
                    Purchases.shared.getOfferings { offerings, error in
                        if let offer = offerings?.current, error == nil {
                            currentOffering = offer
                        }
                    }
                }
            }
        }
   
    }
}

struct SkiesPlusView_Previews: PreviewProvider {
    static var previews: some View {
        SkiesPlusView(subModel: SubscriptionModel())
            .environmentObject(SubscriptionModel())
    }
}
