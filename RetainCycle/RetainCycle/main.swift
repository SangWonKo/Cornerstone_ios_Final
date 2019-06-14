//
//  main.swift
//  RetainCycle
//
//  Created by 고상원 on 2019-05-23.
//  Copyright © 2019 고상원. All rights reserved.
//

import Foundation

class Apartment {
    let unit: String
    weak var tenant: Person?
    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is being initialized")
    }
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

class Person {
    let name: String
    var apartment: Apartment?
    // when creating an instance
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    // when getting deinitialized
    deinit {
        print("\(name) is killed")
    }
}

//var tom: Person?
//var waterfront: Apartment?
//
//tom = Person(name: "Tom")
//waterfront = Apartment(unit: "123A")
//
//tom!.apartment = waterfront
//waterfront!.tenant = tom
//
//tom = nil
//waterfront = nil

//var person1: Person?
//var person2: Person?
//var person3: Person?
//
//person1 = Person(name: "Tom")
//person2 = person1
//person1 = nil

// strong, weak, unowned
// weak - Optional (can be nil)
//      - delegate (weak)

// unowned reference
// Like a weak reference, an unowned reference does not keep a strong held on the instance it referes to.
// Unlike a weak reference, an unowned reference is used when the other instance has the same lifetime or a longer lifetime.

// Use an unowned reference only when you are sure that the reference always refers to an instance that has not been deallocated. %
// % if you try to access the value of an unowned reference after that instance has been deinitialized,

// Customer(Person) ----- CreditCard

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
        print("CreditCard #\(number) is being initialized")
    }
    
    deinit {
        print("CreditCard #\(number) is being deinitialized")
    }
    
}

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var tom: Customer?
tom = Customer(name: "Tom")
tom?.card = CreditCard(number: 123456787654, customer: tom!)

tom = nil

// Retain cycle for Closures (reference type)

class HTMLElement {
    let name: String // p
    let text: String? // some paragraph
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)/>"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var heading:HTMLElement? = HTMLElement(name: "hi", text: "Welcome to my website")

print(heading!.asHTML())

heading = nil


