//
//  PlayGround.swift
//  GCDPlayground
//
//  Created by Mohamed Korany on 9/9/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import Foundation

class Playground {
    
    func doThreadExplosion(){
        /// Create concurrent queue
        /// DEAD LOCK
        let queue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)
        /*From the main queue we call a sync operation on the same queue. The main thread is blocked, since there are no available threads in the pool. At the same time, all the threads in the pool are waiting for the main thread.
         Since they are both waiting for each other, hence the deadlock occurs.*/
        for _ in 0..<999 {
            // 1
            queue.async {
                sleep(1000)
            }
        }
        // 2
        DispatchQueue.main.sync {
            queue.sync {
                print("Done")
            }
        }
    }
    
    
    func doQualityOfServiceThreades() {
        DispatchQueue.global(qos: .background).async {
            print("background")
            
        }
        DispatchQueue.global(qos: .userInitiated).async {
            print("userInitiated")
        }
        DispatchQueue.global(qos: .userInitiated).async {
            print("userInitiated")
        }
        DispatchQueue.global(qos: .userInteractive).async {
            print("userInteractive")
        }
    }
    
    
    func doCustomQueue() {
        _ = DispatchQueue(label: "concurrentqueue", qos: .background, attributes: .concurrent)
        _ = DispatchQueue(label: "serial", qos: .background)
    }
    
    
    func compineDiffrentTypeOfQueues() {
        /*Usually in a real world scenario you often need to use those queues together.
         Let us say you need to do a heavy operation like downloading and image and then display this image in an imageView. */
        
        DispatchQueue.global(qos: .background).async {
            
            let image = "Image Downloaded from server"
            DispatchQueue.main.async {
                let addingImageToUI = image
                print("this is must updated in main thread \(addingImageToUI)")
            }
        }
    }
    
    
    func playThreadsAsync() {
        DispatchQueue.global(qos: .background).async {
            for i in 0...10{
                // sleep(1)
                print("😂 \(i)")
            }
        }
        
        // will play first cause of  piriorty
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 0...10{
                //sleep(1)
                print("💖 \(i)")
            }
        }
    }
    
    
    func playCustomQueueSync() {
        let queue = DispatchQueue(label: "test")
        queue.sync {
            for i in 0...20 {
                sleep(1)
                print("Ⓜ️ \(i)")
            }
            
        }
        
        // execute after thread finishing beacause of sync
        // if we make it async then we go other results
        for i in 0...5 {
            print("queue is finished \(i)")
        }
    }
    
    func playWithMultipleQueues(){
        //they have the same priority during execution
        let queue1 = DispatchQueue(label: "com.appcoda.queue1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.appcoda.queue2", qos: DispatchQoS.userInitiated)
        
        
        queue1.async {
            for i in 0...10{
                print("💖 \(i)")
            }
        }
        
        queue2.async {
            for i in 0...10{
                print("Ⓜ️ \(i)")
            }
        }
        // output will be merge beween them cause we have same piriorty
        // we got other result if we give some one low piority than the another one
        
        
        
        for _ in 0...10 {
            print("this is  the main thread")
        }
    }
    
    
    
    func doManyThreadsInSameCustomQueueSerial() {
        let anotherQueue = DispatchQueue(label: "test.serial.queue", qos: .utility)
        
        anotherQueue.async {
            for i in 0...10 {
                sleep(1)
                print("⚽" , i)
            }
        }
        anotherQueue.async {
            
            for i in 0...10 {
                sleep(1)
                print("🔮" , i)
            }
        }
        anotherQueue.async {
            
            for i in 0...10 {
                sleep(1)
                print("🎱" , i)
            }
        }
        
        // output will be like finish first then finish second then finish third
        // reason is the tasks will be executed in a serial mode
    }
    
    
    
    
    func doManyThreadsInSameCustomQueueConcurrent() {
        let anotherQueue = DispatchQueue(label: "test.concurrent", qos: .utility , attributes: .concurrent)
        
        anotherQueue.async {
            for i in 0...10 {
                sleep(1)
                print("⚽" , i)
            }
        }
        anotherQueue.async {
            
            for i in 0...10 {
                sleep(1)
                print("🔮" , i)
            }
        }
        anotherQueue.async {
            
            for i in 0...10 {
                sleep(1)
                print("🎱" , i)
            }
        }
    }
    
    func doManyThreadsInSameCustomQueueinactiveQueue(){
        
        var inactiveQueue: DispatchQueue!
        let anotherQueue = DispatchQueue(label: "test.inactive.queue", qos: .utility, attributes: .initiallyInactive)
        inactiveQueue = anotherQueue
        
        // we need to do that otherwise we have a problem that queue will be inactive
        if let queue = inactiveQueue {
            queue.activate()
        }
        
        
        anotherQueue.async {
            for i in 0...10 {
                sleep(1)
                print("⚽" , i)
            }
        }
        anotherQueue.async {
            
            for i in 0...10 {
                sleep(1)
                print("🔮" , i)
            }
        }
        anotherQueue.async {
            
            for i in 0...10 {
                sleep(1)
                print("🎱" , i)
            }
        }
        // output will be first for then second for then the last one because queue is serial
        // we can make it inactive and concurrent same time by attributes: [.concurrent, .initiallyInactive])
    }
    
    func applyDelayOnQueue() {
        
        let delayQueue = DispatchQueue(label: "test.delay", qos: .userInitiated)
        delayQueue.asyncAfter(deadline: .now() + 1) {
            print(Date())
        }
    }
    
    func globalQueueWithMainQueue() {
        let globalQueue = DispatchQueue.global(qos: .userInitiated)
    }
    
}
