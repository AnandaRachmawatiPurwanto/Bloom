//
//  BookingDetailViewModel.swift
//  Bloom
//
//  Created by Rendi Septrian on 12/07/26.
//
import SwiftUI
import Observation
import FirebaseDatabase

@Observable class BookingDetailViewModel {
    var isCollected: Bool = false
    
    func listenToFirebase() {
        let databaseURL = "https://vending-pembalut-default-rtdb.asia-southeast1.firebasedatabase.app"
        let ref = Database.database(url: databaseURL).reference()
        let node = ref.child("vending_machines/MESIN_PEMBALUT_01/trigger_keluarkan")
        
        node.setValue(false) { error, _ in
            if let error = error {
                print("Gagal mereset Firebase: \(error.localizedDescription)")
                return
            }
            
            node.observe(.value) { snapshot in
                if let value = snapshot.value as? Bool, value == true {
                    withAnimation {
                        self.isCollected = true
                    }
                }
            }
        }
    }
}
