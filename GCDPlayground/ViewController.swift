//
//  ViewController.swift
//  GCDPlayground
//
//  Created by Mohamed Korany on 9/9/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var service = Service()
    var group = BatchingTasks()
    var pg = Playground()
    var sem = Semaphores()
    override func viewDidLoad() {
        super.viewDidLoad()
    
       // service.doSomething()
       /// group.dispatchGroupNotify()
       // pg.doThreadExplosion()
       // pg.playThreadsAsync()
       // pg.playCustomQueueSync()
       // pg.playWithMultipleQueues()
       // pg.doManyThreadsInSameCustomQueueSerial()
       // pg.doManyThreadsInSameCustomQueueinactiveQueue()
       // pg.applyDelayOnQueue()
      //  pg.doManyThreadsInSameCustomQueueConcurrent()
        //group.specifyOnThreadEnterBydispatchGroup()
        
        //sem.applySemaphore()
        sem.applyTwoSemaphores()
        

    }
    
    func basic(){
        // Do work synchronously
        //finish task then enter another task
        DispatchQueue.global().sync { }

        // Do work asynchronously
        // multitasking
        DispatchQueue.global().async {  }
        
        
        
        let queue = DispatchQueue(label: "Some serial queue")

        // Do work synchronously
        queue.sync {  }

        // Do work asynchronously
        queue.async {  }
    }
    
    func showAlert() {
        DispatchQueue.main.async {
            // show alert if you are in another thread
        }
    }
    
    
    
}


