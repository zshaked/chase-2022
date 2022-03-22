//
//  HighSchoolHome.swift
//  List App With API
//
//  Created by 123456 on 11/8/21.
//

import SwiftUI

struct HighSchoolHome: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView{
        List{
            ForEach(modelData.highSchools) {
                school in
                NavigationLink {
                    HighSchoolRow(highSchool: school)
                } label: {
                    Text(school.name)
                        .bold()
                }
            }
        }
            .navigationTitle("High Schools")
            .task {
                await modelData.loadSchools()
            }
        }
    }
}

struct HighSchoolHome_Previews: PreviewProvider {
    static var previews: some View {
        HighSchoolHome().environmentObject(ModelData())
    }
}
