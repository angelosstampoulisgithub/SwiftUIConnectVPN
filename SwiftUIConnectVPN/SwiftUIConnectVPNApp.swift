//
//  SwiftUIConnectVPNApp.swift
//  SwiftUIConnectVPN
//
//  Created by Angelos Staboulis on 21/5/25.
//

import SwiftUI

@main
struct SwiftUIConnectVPNApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vpnName: "", selected: false).frame(width:650,height:200,alignment: .center)
        }.windowResizability(.contentSize)
    }
}
