//
//  HighSchoolRow.swift
//  List App With API
//
//  Created by 123456 on 11/8/21.
//

import SwiftUI

struct HighSchoolRow: View {
 
    @State var highSchool:HighSchool
    
    var body: some View {
        Group{
            Text(highSchool.name)
                .bold()
            
            VStack{
                Text("SAT Total: \(highSchool.sat.totalTakers)")
                Text("SAT Math: \(highSchool.sat.math)")
                Text("SAT Reading: \(highSchool.sat.reading)")
                Text("SAT Writing: \(highSchool.sat.writing)")
            }
        }.task {
            highSchool.sat = await ModelData().loadSAT(schoolID: highSchool.id)
            
            print(highSchool.sat)
        }
    }
}

struct HighSchoolRow_Previews: PreviewProvider {
    static var previews: some View {
        HighSchoolRow(highSchool: HighSchool.highSchools[0])
    }
}
