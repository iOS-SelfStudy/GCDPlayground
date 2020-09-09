//
//  Semaphore.swift
//  GCDPlayground
//
//  Created by Mohamed Korany on 9/9/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import Foundation
class Semaphores {
    
    
    //The value parameter is the number of threads that can access to the resource as for the semaphore creation.
    let semaphore = DispatchSemaphore(value: 1)
    
     func applySemaphore() {
        
        let higherPriority1 = DispatchQueue.global(qos: .userInteractive)
        let lowerPriority1 = DispatchQueue.global(qos: .background)
        
        higherPriority1.async {
            print("🔴 waiting")
            self.semaphore.wait() // request resource
            
            for i in 0...10 {
                 sleep(1)
                print("🔴", i)
            }
            print("🔴 signal")
            self.semaphore.signal()
        }
        
        
        lowerPriority1.async {
            print("🔵 waiting")
            self.semaphore.wait() // request resource
            
            for i in 0...10 {
                sleep(1)
                print("🔵", i)
            }
            print("🔵 signal")
            self.semaphore.signal()
        }
        
        /*when one thread starts printing the sequence, the other thread must wait until the first one ends, then the semaphore will receive the signal from the first thread and then, only then, the second thread can start printing its own sequence.*/
    }
    
    
    
    
    let higherPriority2 = DispatchQueue.global(qos: .userInitiated)
    let lowerPriority2 = DispatchQueue.global(qos: .utility)

    let semaphoreA = DispatchSemaphore(value: 1)
    let semaphoreB = DispatchSemaphore(value: 1)

    func asyncPrint(queue: DispatchQueue, symbol: String, firstResource: String, firstSemaphore: DispatchSemaphore, secondResource: String, secondSemaphore: DispatchSemaphore) {
      func requestResource(_ resource: String, with semaphore: DispatchSemaphore) {
        print("\(symbol) waiting resource \(resource)")
        semaphore.wait()  // requesting the resource
      }
      
      queue.async {
        requestResource(firstResource, with: firstSemaphore)
        for i in 0...10 {
            sleep(1)
          if i == 5 {
            requestResource(secondResource, with: secondSemaphore)
          }
          print(symbol, i)
        }
        
        print("\(symbol) releasing resources")
        firstSemaphore.signal() // releasing first resource
        secondSemaphore.signal() // releasing second resource
      }
    }
    
    func applyTwoSemaphores() {
        asyncPrint(queue: higherPriority2, symbol: "🔴", firstResource: "A", firstSemaphore: semaphoreA, secondResource: "B", secondSemaphore: semaphoreB)
        asyncPrint(queue: lowerPriority2, symbol: "🔵", firstResource: "B", firstSemaphore: semaphoreB, secondResource: "A", secondSemaphore: semaphoreA)
    }
    
    
}


/*
 To request the semaphore’s resource(s
 semaphore.wait()
 
 //To release the resource
 semaphore.signal()
 
 Note : After sending this signal we aren’t allowed to touch the resource anymore, until we request for it again.*/
