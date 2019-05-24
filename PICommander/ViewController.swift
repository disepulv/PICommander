//
//  ViewController.swift
//  PICommander
//
//  Created by Diego Sepúlveda on 10/21/18.
//  Copyright © 2018 7soft. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!

    let swiftPi = SwiftPi(username:"pi", password: "pass", ip:"192.168.1.xxx", port: "8888")

    let relayArr = [SwiftPi.GPIO.SEVENTEEN, SwiftPi.GPIO.TWENTYTWO, SwiftPi.GPIO.THIRTEEN, SwiftPi.GPIO.SIX]

    let moistureSensor = SwiftPi.GPIO.TWENTYONE

    override func viewDidLoad() {
        super.viewDidLoad()
        // SET UP
        for relay in relayArr {
            swiftPi.setMode(relay, mode: .OUT)
        }

        switch1.isOn = swiftPi.getBooleanValue(relayArr[0])
        switch2.isOn = swiftPi.getBooleanValue(relayArr[1])
        switch3.isOn = swiftPi.getBooleanValue(relayArr[2])
        switch4.isOn = swiftPi.getBooleanValue(relayArr[3])
    }

    /*
     0 or LOW (0V) = Relay ON
     1 or HIGH (3V3) = Relay OFF
     */
    @IBAction func onoff(_ sender: UISwitch) {
        var GPIO : SwiftPi.GPIO = .SEVENTEEN
        switch sender {
        case switch2:
            GPIO  = .TWENTYTWO
            break
        case switch3:
            GPIO  = .THIRTEEN
            break
        case switch4:
            GPIO  = .SIX
            break
        default:
            print("do nothing")
        }

        if !sender.isOn {
            swiftPi.setValueInBackground(GPIO, value: .ON) { (result) -> Void in
                if let res = result {
                    print("ON -> \(res)")
                }
            }
        } else {
            swiftPi.setValueInBackground(GPIO, value: .OFF) { (result) -> Void in
                if let res = result {
                    print("OFF -> \(res)")
                }
            }
        }
    }
}

