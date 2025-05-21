//
//  VPNManager.swift
//  SwiftUIConnectVPN
//
//  Created by Angelos Staboulis on 21/5/25.
//

import Foundation
class VPNManager{
    func err(_ message: String) {
        FileHandle.standardError.write((message + "\n").data(using: .utf8)!)
    }
    func isConnected(vpnName: String) -> Bool? {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/networksetup")
        task.arguments = ["-showpppoestatus", vpnName]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = FileHandle.standardError

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            err("Error executing networksetup: \( error)")
            return nil
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? ""

        if task.terminationStatus != 0 {
            err("networksetup command failed with exit code: \( task.terminationStatus)")
            return nil 
        }

        return output.lowercased().contains("connected")
    }



    func startVPN(vpnName: String) -> Bool {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/scutil")
        task.arguments = ["--nc", "start", vpnName]
        task.standardOutput = FileHandle.standardOutput
        task.standardError = FileHandle.standardError

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            err("Error executing scutil start: \( error)")
            return false
        }

        return task.terminationStatus == 0
    }


    func stopVPN(vpnName: String) -> Bool {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/scutil")
        task.arguments = ["--nc", "stop", vpnName]
        task.standardOutput = FileHandle.standardOutput
        task.standardError = FileHandle.standardError

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            err("Error executing scutil stop: \( error)")
            return false
        }

        return task.terminationStatus == 0
    }


    


   

}
