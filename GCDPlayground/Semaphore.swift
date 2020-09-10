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
        
        let higherPriority1 = DispatchQueue.global(qos: .background)
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
    
    func do2TasksAtATime () {
        let queue1 = DispatchQueue(label: "1")
        let queue2 = DispatchQueue(label: "2")
        let queue3 = DispatchQueue(label: "3")
        print("starting long running tasks (2 at a time)")
        let sem = DispatchSemaphore(value: 2)  //this semaphore only allows 2 tasks to run at the same time (the resource count)
        for i in 0...2 {
            queue1.async {
                sem.wait()
                print("queue1  \(i) done! \(Date())")
                
            }
            queue2.async {
                sem.wait()
                print("queue2  \(i) done! \(Date())")
            }
            
            queue3.async {
                sem.wait()
                print("queue3  \(i) done! \(Date())")
            }
            print("wait 4 seconds to get resource")
            sleep(4)
            sem.signal()
        }
    }
}


/*
 To request the semaphore’s resource(s
 semaphore.wait()
 
 //To release the resource
 semaphore.signal()
 
 Note : After sending this signal we aren’t allowed to touch the resource anymore, until we request for it again.*/
