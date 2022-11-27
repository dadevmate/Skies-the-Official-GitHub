//
//  SubscriptionModel.swift
//  Skymie
//
//  Created by Nethan on 24/11/22.
//

import Foundation
import SwiftUI
import RevenueCat

class SubscriptionModel : ObservableObject {
    @Published var isSubscriptionActive = false
    
    init() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            self.isSubscriptionActive = customerInfo?.entitlements.all["tier 1"]?.isActive == true
        }
    }
}

class SubscriptionModelTwo : ObservableObject {
    @Published var isSubscriptionActive = false
    
    init() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            self.isSubscriptionActive = customerInfo?.entitlements.all["tier 2"]?.isActive == true
        }
    }
}
