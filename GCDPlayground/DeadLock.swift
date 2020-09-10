//
//  DeadLock.swift
//  GCDPlayground
//
//  Created by Mohamed Korany on 9/10/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import Foundation
class DeadLock {
    let higherPriority = DispatchQueue.global(qos: .userInteractive)
    let lowerPriority = DispatchQueue.global(qos: .background)

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
          if i == 2 {
            requestResource(secondResource, with: secondSemaphore)
          }
          print(symbol, i)
        }
        
        print("\(symbol) releasing resources")
        firstSemaphore.signal() // releasing first resource
        secondSemaphore.signal() // releasing second resource
      }
    }

     
    func doDeadLock() {
        asyncPrint(queue: higherPriority, symbol: "🔴", firstResource: "A", firstSemaphore: semaphoreA, secondResource: "B", secondSemaphore: semaphoreB)
           asyncPrint(queue: lowerPriority, symbol: "🔵", firstResource: "B", firstSemaphore: semaphoreB, secondResource: "A", secondSemaphore: semaphoreA)
    }
   
}
