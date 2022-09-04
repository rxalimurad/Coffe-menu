//
//  FinishRegistractionView.swift
//  Coffe menu
//
//  Created by Ali Murad on 02/09/2022.
//

import SwiftUI

struct FinishRegistractionView: View {
    @State var name = ""
    @State var surename = ""
    @State var telephone = ""
    @State var address = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Form {
            Section() {
                Text("Finish Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 20)
                TextField("Name", text: $name)
                TextField("SurName", text: $surename)
                TextField("Telephone", text: $telephone)
                TextField("Address", text: $address)
            }
            
            Section {
                Button(action: {
                    finishRegistraction()
                }) {
                    Text("Finish Registraction")
                }.disabled(!fieldsCompleted())
            }
        }
        
    }
    
    private func fieldsCompleted() -> Bool {
        return !self.name.isEmpty && !self.surename.isEmpty && !self.telephone.isEmpty && !self.address.isEmpty
    }
    private func finishRegistraction() {
        let fullName = name + " " + surename
        FUser.updateCurrentUser(withValues: [
            kFIRSTNAME : name,
            kLASTNAME : surename,
            kFULLNAME : fullName,
            kFULLADDRESS : address,
            kPHONENUMBER : telephone,
            kONBOARD : true,
           
        ]) {error in
            if error != nil {
                print ("error uddating user", error!.localizedDescription)
                return
            }
            self.presentationMode.wrappedValue.dismiss()
            
        }
        
        
    }
}

struct FinishRegistractionView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistractionView()
    }
}
