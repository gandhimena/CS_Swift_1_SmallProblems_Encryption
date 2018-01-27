//
//  ViewController.swift
//  Encryption
//
//  Created by spychatter mx on 1/25/18.
//  Copyright © 2018 trenx. All rights reserved.
//

import UIKit


typealias OTPKey = [UInt8]
typealias OTPKeyPair = (key1: OTPKey, key2: OTPKey)

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let result = decryptOTP(keyPair: encryptOTP(original: "Vamos"))
		print(result ?? "")
	}
	
	//Desencrypt
	func decryptOTP(keyPair: OTPKeyPair) -> String?{
		let decrypted: OTPKey = keyPair.key1.enumerated().map{ $1 ^ keyPair.key2[$0]}
		return String(bytes: decrypted, encoding: .utf8)
	}

	//Encrypt
	func encryptOTP(original:String) -> OTPKeyPair{
		let dummy = randomOTPKey(length: original.utf8.count)
		let encrypted: OTPKey = dummy.enumerated().map{
			return $1 ^ original.utf8[original.utf8.index(original.utf8.startIndex, offsetBy: $0)]
		}
		return (dummy, encrypted)
	}
	
	//getRandomFromLength
	func randomOTPKey(length: Int) -> OTPKey{
		return random(randomKey: OTPKey())(length)
	}
	
	//random
	func random(randomKey: OTPKey) -> (Int) -> OTPKey{
		return { return Array(0..<$0).map{ _ in
				UInt8(arc4random_uniform(UInt32(UInt8.max)))
			}
		}
	}


}

