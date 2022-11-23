//
//  NoConnectionView.swift
//  Skymie
//
//  Created by Nethan on 21/11/22.
//

import SwiftUI

struct NoConnectionView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "wifi.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Spacer()
            Text("Please connect to the internet and restart\nthe app to continue using Skies")
                .fontWeight(.light)
            Spacer()
      
   
        }
    }
}

struct NoConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView()
    }
}
