//
//  ContentView.swift
//  List App With API
//
//  Created by 123456 on 11/8/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        HighSchoolHome()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
