//
//  CardPhoneEmailView.swift
//  Cards
//
//  Created by Adam West on 17.01.2024.
//

import SwiftUI

struct CardPhoneEmailView: View {
    // MARK: Private properties
    private var email: String
    private var phone: String
    
    // MARK: Initialization
    init(email: String, phone: String) {
        self.email = email
        self.phone = phone
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Email")
                .bold()
                .font(.title2)
            
            Text(email)
                .font(.title3)
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .italic()
       
            Text("Phone")
                .bold()
                .font(.title2)
            
            Text(phone)
                .font(.title3)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .italic()
          
        }
    }
}

struct CardPhoneEmailView_Previews: PreviewProvider {
    static var previews: some View {
        CardPhoneEmailView(email: "jennie.nichols@example.com", phone: "(272) 790-0888")
    }
}
