//
//  ContentView.swift
//  SwiftUIConnectVPN
//
//  Created by Angelos Staboulis on 21/5/25.
//

import SwiftUI

struct ContentView: View {
    let vpn = VPNManager()
    @State var vpnName:String
    @State var selected:Bool
    var body: some View {
        VStack {
            HStack{
                VStack{
                    Text("Enter VPN Name").frame (width:300,alignment: .leading)
                    TextField("Enter VPN Name", text: $vpnName).frame(width:300,alignment: .leading).padding(10)
                    Toggle("VPN " + vpnName, isOn: $selected).frame(width:299,alignment: .leading)
                }
                VStack{
                    Button {
                        if vpn.startVPN(vpnName: vpnName) {
                            selected.toggle()
                        }
                    } label: {
                        Text("Start VPN").frame(width:200,height:65)
                    }.frame(width:300,height:65)
                    Button {
                        if vpn.stopVPN(vpnName: vpnName) {
                            selected.toggle()
                        }
                    } label: {
                        Text("Stop VPN").frame(width:200,height:65)
                    }.frame(width:200,height:65)
                }
            }.frame(width:200,height:165)
        }
        
    }
}

#Preview {
    ContentView(vpnName: "", selected: false)
}
