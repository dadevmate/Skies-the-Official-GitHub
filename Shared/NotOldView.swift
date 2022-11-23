//
//  NotOldView.swift
//  Skymie
//
//  Created by Nethan on 3/7/22.
//

import SwiftUI

struct NotOldView: View {
    var body: some View {
   
        VStack {
            Spacer()
        
        Text("We're sorry, but you're not old \n enough to use this app!")
            .fontWeight(.bold)
            .font(.title2)
            Spacer()
            
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 80))
            Spacer()
        Text(" We want Skies to be a good place \n for everyone. Unfortunately, you're not \n old enough to use it \n \n We'll always be here. Come back when \n your at least 13 years old.")
        Spacer()
            Spacer()
  
        }
    }
}

struct NotOldView_Previews: PreviewProvider {
    static var previews: some View {
        NotOldView()
    }
}
